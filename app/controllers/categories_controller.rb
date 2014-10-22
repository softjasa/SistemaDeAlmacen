class CategoriesController < ApplicationController

	def index
    @categories = Category.order(params[:sort]).paginate(:per_page => 6, :page => params[:page])
  	end

  	def show
    	@category = Category.find(params[:id])
	end

  
  	def new
    	@category = Category.new
	end

  
  	def edit
    	@category = Category.find(params[:id])
  	end

  	def create
    	@category = Category.new(params[:category])
      if @category.save
         flash[:success] = 'Categoria Creada exitosamente.' 
       	redirect_to '/categories'
      else
        render action: "new" 
      end
  	end

  def update
  	@category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
       flash[:success] = 'Categoria Actualizada exitosamente.'
	    redirect_to @category
    else
    	render action: "edit" 
    end
  end

  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_url 
  end

  def search
    #@categories = buscar(params[:name])
    @categories = Category.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Category.all
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
