class ProductnamesController < ApplicationController
	def index
    @productnames = Productname.order('name ASC').paginate(:per_page => 6, :page => params[:page])
  end

  def show
   	@productname = Productname.find(params[:id])
	end

  def new
   	@productname = Productname.new
	end

  def edit
   	@productname = Productname.find(params[:id])
  end

  def create
    @brand = Brand.find(params[:productname][:brand_id])
    @productname = @brand.productnames.create(params[:productname])
    if @productname.save 
      flash[:success] = "Producto creado exitosamente!"
      redirect_to @productname
    else
      flash[:danger] = "Producto no creado, faltan llenar campos"
      render action: "new"
    end
  end

  def update
  	@productname = Productname.find(params[:id])
    if @productname.update_attributes(params[:productname])
	    flash[:success] = "Producto editado exitosamente!"
      redirect_to @productname
      #redirect_to '/productnames'
    else
    	render action: "edit" 
    end
  end

  
  def destroy
    control = true
    @productname = Productname.find(params[:id])
    @productname.productorders.each do |productorder|
      if productorder.productname_id = @productname.id
        control = false
        flash[:danger] = "No puede eliminar el producto porque existen pedidos asociados a este."    
      end
      break if control == false
    end
    if control == true
      flash[:success] = "Se elimino el producto exitosamente."
      @productname.destroy
    end
    redirect_to productnames_url 
  end

  def search
    #@productnames = buscar(params[:name])
    @productnames = Productname.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Productname.all
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
