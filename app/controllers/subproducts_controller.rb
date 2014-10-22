class SubproductsController < ApplicationController

	def create
		@product = Product.find(params[:product_id])
		@subproduct = @product.subproducts.create(params[:subproduct].permit(:code, :name))
		redirect_to product_path(@product)
  	end

  	def destroy
  		@product = Product.find(params[:product_id])
  		@subproduct = @product.subproducts.find(params[:id])
  		@subproduct.destroy
  		redirect_to product_path(@product)    	
  	end

    def index
      @subproducts = Subproduct.all   
    end

    def agregar_subproducto_venta
      @subproduct = Subproduct.find(params[:id])
      @product = Product.find(@subproduct.product_id)
      @product.disminuir
      @product.save
      @subproduct.sale_id = params[:sale_id]
      @subproduct.available = false
      @subproduct.save
      @sale = Sale.find(params[:sale_id])
      @sale.price = @sale.price + @subproduct.product.sale_price
      @sale.save
      redirect_to sale_path(@sale)
    end

    def eliminar_subproducto_venta
      @subproduct = Subproduct.find(params[:id])
      @product = Product.find(@subproduct.product_id)
      @product.aumentar
      @product.save
      @subproduct.sale_id = nil
      @subproduct.available = true  
      @subproduct.save
      @sale = Sale.find(params[:sale_id])
      @sale.price = @sale.price - @subproduct.product.sale_price 
      @sale.save
      redirect_to sale_path(@sale)
    end
end
