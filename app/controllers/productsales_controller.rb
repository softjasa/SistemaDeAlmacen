class ProductsalesController < ApplicationController

	def new
		@productsale = Productsale.new
	end

	def create
		@subproduct = Subproduct.find(params[:productsale][:subproduct_id].to_i)
		@product = Product.find(@subproduct.product_id)
		@product.quantity -= 1
		@product.save
		@sale = Sale.find(params[:sale_id])
		if params[:productsale][:price].to_f >= 0
			@sale.price += params[:productsale][:price].to_f
			@sale.save 
			@productsale = Productsale.new
			@productsale.name = @subproduct.name
			@productsale.code = @subproduct.code
			@productsale.sale_id = params[:sale_id]
			@productsale.price = params[:productsale][:price]
			@productsale.subproduct_id = @subproduct.id
			@subproduct.sale_id = params[:sale_id]
			@subproduct.available = false
			@subproduct.save
			if @productsale.save
				flash[:success] = "Producto agregado a venta exitosamente."
				redirect_to "/sales/"+@productsale.sale_id.to_s
			end
		else
			flash[:danger] = "Precio de venta no puede ser negativo"
		    redirect_to sale_path(@sale)
		end
	end

	def eliminar_subproducto_venta
		@productsale = Productsale.find(params[:id])
		@subproduct = Subproduct.find(@productsale.subproduct_id)
		@product = Product.find(@subproduct.product_id)
		@product.quantity += 1
		@product.save
		@subproduct.available = true
		@subproduct.save
		@sale = Sale.find(@productsale.sale_id)
		@sale.price = @sale.price - @productsale.price
      	@sale.save
     	@productsale.destroy
		redirect_to sale_path(@sale)
	end

end
