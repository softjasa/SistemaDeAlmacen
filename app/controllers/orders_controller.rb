class OrdersController < ApplicationController
	def show
		@order = Order.find(params[:id])
	end

	def new	
		@order = Order.new
	end
  
	def index
		@orders1 = Order.all
		@orders1.each do |order|
			if order != nil && order.confirm == false
				order.destroy
			end
		end
		@orders = Order.order(params[:created_at]).paginate(:per_page => 6, :page => params[:page])
	end

	def mostrar
		@order = Order.find(params[:id]) 
	end

	def create
		@order = Order.new
		@order.id = @order.id
	    @order.estado = params[:estado]
	    @order.provider_id = params[:provider_id]
	    @order.ingresado = params[:ingresado]
	    @order.confirm = false
	    if @order.save
	      redirect_to @order
	    else
	      flash[:message] = "Verifique los Campos Marcados"
	      render :action => 'new'
	    end
  	end

	def search
		@orders = buscar(params[:name]).paginate(:page => params[:page], :per_page => 6 )
		#@orders = Order.where("provider_id.name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
		render 'index'
	end

	def buscar(proveedor)
    	items = Array.new	
    	aux = Order.all
    	if proveedor != "" && proveedor != nil
      		aux.each do |item|
        	if (item.correspondeAproveedor(proveedor))
          		items.push(item)
        	end
      	end
    	else
      		items = aux
    	end
    	return items
  	end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy
		redirect_to orders_url
	end

	def edit
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		order = params[:order]
		@order.created_at = Date.new order["created_at(1i)"].to_i, order["created_at(2i)"].to_i, order["created_at(3i)"].to_i
		@order.confirm = true
		if @order.update_attributes(params[:order])
			@order.save
			flash[:success] = "Pedido registrado exitosamente!"
			#redirect_to @order			
			redirect_to '/orders/'
		else
			render 'edit'
		end
	end

	def guardar_proveedor
		@order = Order.find(params[:id])
		@order.provider_id = params[:provider_id]
		@order.save
		redirect_to '/orders/'
	end

end
