class BrandsController < ApplicationController

	def index
    @brands = Brand.order(params[:sort]).paginate(:per_page => 6, :page => params[:page])
    
    #@brands = Brand.
  end

  def show
   	@brand = Brand.find(params[:id])
	end
  
  def new
   	@brand = Brand.new
	end

  def edit
   	@brand = Brand.find(params[:id])
  end

  def create
   	@brand = Brand.new(params[:brand])
    if @brand.save
      flash[:success] = 'Marca creada exitosamente.' 
     	redirect_to '/brands'
    else
      render action: "new" 
    end
  end

  def update
  	@brand = Brand.find(params[:id])
    if @brand.update_attributes(params[:brand])
       flash[:success] = 'Marca actualizada exitosamente.'
	    redirect_to '/brands'
    else
    	render action: "edit" 
    end
  end

  def destroy
    control = true
    @brand = Brand.find(params[:id])
    @brand.productnames.each do |productname|
      if productname.brand_id == @brand.id
        control = false
        flash[:danger] = "No puede eliminar la marca porque existen productos asociados a esta."    
      end
      break if control == false
    end
    if control == true
      flash[:success] = "Se elimino la marca exitosamente."
      @brand.destroy
    end
    redirect_to brands_url 
  end
  
  def search
    #@brands = buscar(params[:name])
    @brands = Brand.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Brand.all
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
