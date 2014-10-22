	class ProductsController < ApplicationController
	def index
		@products = Product.paginate(:per_page => 6, :page => params[:page])		
	end

	def show
		@product = Product.find(params[:id])
	end	

	def inventario
		@products = Product.all
	end

	def new
		@product = Product.new
		@order = Order.find(params[:id])
		@select = "almacen"
	end

	def search
		#@products = buscar(params[:name])
		@products = Product.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
		render 'index'
	end

	def buscar(nombre)
    	items = Array.new	
    	aux = Product.all
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


	def search_home
		@products = Product.where("category like ?", "%#{params[:category]}%").paginate(:per_page => 6, :page => params[:page])
		render 'products_home'
	end

	def buscar_home(categoria)
    	items = Array.new	
    	aux = Product.all
    	if categoria != "" && categoria != nil
      		aux.each do |item|
        	if (item.correspondeAcategoria(categoria))
          		items.push(item)
        	end
      	end
    	else
      		items = aux
    	end
    	return items
  	end


  	def search_to_home
		#@products = buscar_por_nombre(params[:name])
		@products = Product.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
		render 'products_home'
	end

	def buscar_por_nombre(nombre)
    	items = Array.new	
    	aux = Product.all
    	if nombre != "" && nombre != nil
      		aux.each do |item|
        	if (item.correspondeApagina(nombre))
          		items.push(item)
        	end
      	end
    	else
      		items = aux
    	end
    	return items
  	end

  	def registrar_ingreso
  		@products = Product.all
  		@productorder = Productorder.find(params[:id].to_i)
  		@productorder.ingresado = true
	  	@productorder.save
  		@productname = Productname.find(@productorder.productname_id.to_i)
  		@income = Income.new
  		@income.registrar(@productorder)
  		@income.save
  		@kardex = Kardex.new
  		@kardex.detail = "Pedido " + @productorder.order_id.to_s
  		@kardex.income = @productorder.quantity
  		@kardex.date = @productorder.updated_at
  		control = false
  		if @products.length > 0
	  		@products.each do |product|
	  			if product.general_code == @productname.code
	  				product.quantity += @productorder.quantity
	  				product.save
	  				@kardex.residue = product.quantity
	  				@kardex.product_id = product.id
	  				@kardex.save
	  				control = true
	  			end
	  			break if control == true
	  		end
	  		if control == true
	  			flash[:success] = "Producto ingresado exitosamente."
	  			redirect_to '/orders/'+@productorder.order_id.to_s+'/edit'	  		
	  		else
	  			@product = Product.new
	  			@product.registrar(@productorder)
	  			@product.quantity = @productorder.quantity
	  			@product.save
	  			@kardex.residue = @product.quantity
	  			@kardex.product_id = @product.id
	  			@kardex.save
	  			flash[:success] = "Producto ingresado exitosamente."
	  			redirect_to '/orders/'+@productorder.order_id.to_s+'/edit'
	  		end
	  	else
	  		@product = Product.new
	  		@product.registrar(@productorder)
	  		@product.quantity = @productorder.quantity
	  		@product.save
	  		@kardex.residue = @product.quantity
	  		@kardex.product_id = @product.id
	  		@kardex.save
	  		flash[:success] = "Producto ingresado exitosamente."
	  		redirect_to '/orders/'+@productorder.order_id.to_s+'/edit'	  	
	  	end
  	end

	private
	def increase
		if @product.quantity == 0
			i = @product.quantity
			i+=1
		else
			i = @product.quantity
		end
    	@product.quantity = @product.quantity + @product.increase
    	while i < @product.quantity do
      		@product.subproducts.create("code" => @product.general_code + "-#{i}")
      		i = i + 1
    	end
    	@product.increase = 0
    	@product.save
	end
	
	public

	def create
		@product = Product.new(params[:product])
		@productorder = Productorder.find(params[:product][:id])	
		@productorder.ingresado = true
		@productorder.save
		@product.home = false
		@product.description = "          "
		if @product.save
			 flash[:success] = 'Producto creado correctamente.' 
			redirect_to '/products'
		else
			render action: 'new'
		end
	end
	
	def edit_to_home
		@product = Product.find(params[:id])
	end
	
	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product])
			@product.save
			flash[:success] = "Producto Actualizado"
			if params[:product][:control] == "true"
				redirect_to '/products_home'
			else
				redirect_to @product
			end			
		else
			if params[:product][:control] == "true"
				redirect_to '/add_to_home?id='+@product.id.to_s
			else
				render 'edit'
			end
		end
	end

#params[:name], params[:detail], params[:quantity],params[:general_code], params[:brand], params[:category], params[:bought_price],params[:sale_price], params[:created_at], params[:updated_at]
	#def update 
	#	@product = Product.find(params[:id])
	#	if @product.update_attributes(params[:empleado])
	#		@product.save			
	#		if(@product.update_attributes(params[:photo], params[:description]))
	#			flash[:success] = "Producto de Pagina Actualizado"	
	#			redirect_to :controller => :products, :action => 'products_home'	
	#		else
	#			flash[:success] = "Producto Actualizado"
	#			redirect_to @product	
	#		end
	#	else
	#		render 'edit'
	#	end
	#end

	def products_home
		@products = Product.paginate(:per_page => 6, :page => params[:page])
	end

	def view_product
		@product = Product.find(params[:id])
	end

	def add_to_home
		@product = Product.find(params[:id])
		@product.home = true
		@product.save		
	end
	

	def delete_from_home
		@product = Product.find(params[:id])
		@product.home = false
		@product.description =''
		@product.save
		redirect_to :controller => :products, :action => 'index'
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to products_url
	end
end
