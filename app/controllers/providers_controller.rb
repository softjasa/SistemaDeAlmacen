class ProvidersController < ApplicationController

	def index
    @providers = Provider.order(params[:sort]).paginate(:per_page => 5, :page => params[:page])
  end

  def show
  	@provider = Provider.find(params[:id])
	end
  
 	def new
   	@provider = Provider.new
	end

 	def edit
   	@provider = Provider.find(params[:id])
 	end

 	def create
   	@provider = Provider.new(params[:provider])
    if @provider.save
      flash[:success] ='Proveedor creado exitosamente.'
     	redirect_to @provider
    else
      render action: "new" 
    end
	end

  def update
  	@provider = Provider.find(params[:id])
    if @provider.update_attributes(params[:provider])
	    flash[:success] = "Proveedor editado exitosamente."
      redirect_to @provider
    else
    	render action: "edit" 
    end
  end

  def destroy
    control = true
    @provider = Provider.find(params[:id])
    @provider.orders.each do |order|
      if order.provider_id == @provider.id
        control = false
        flash[:danger] = "No puede eliminar el proveedor porque existen pedidos asociados a este."    
      end
      break if control == false
    end
    if control == true
      flash[:success] = "Se elimino el proveedor exitosamente."
      @provider.destroy
    end
    redirect_to providers_url 
  end

  def search
    #@providers = buscar(params[:name])
    @providers = Provider.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Provider.all
      if nombre != "" && nombre != nil
          aux.each do |item|
          if (item.correspondeAnombre(nombre))
              items.push(item)
          end
        end
      else
          items = aux
      end
      return items
    end

end
