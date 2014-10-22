class Productsale < ActiveRecord::Base
	attr_accessible :name, :code, :price, :sale_id, :subproduct_id, :client_name

	belongs_to :sale

	validates :price, numericality: {greater_than: -1, :message => "El precio no puede ser negativo" }

	def guardar(sub,sale)
		self.name = @sub.name
		self.code = @sub.code
		self.sale_id = sale
	end
end
