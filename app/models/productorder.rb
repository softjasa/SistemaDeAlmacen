class Productorder < ActiveRecord::Base
	belongs_to :order
	
	belongs_to :productname 

	attr_accessible :name, :productname_id, :quantity, :code, :ingresado, :description, :price, :total_price, :order_id

	validates :quantity, presence: {:message => "Es un campo obligatorio"}
	
	validates :quantity, numericality: {:message => "La cantidad debe ser numerico"}
	validates :quantity, numericality: {greater_than: 0, :message => "La cantidad debe ser mayor a 0" }

	validates :price, numericality: {greater_than: -1, :message => "El precio no puede ser negativo" }
	#validates :code, presence: {:message => "Es un campo obligatorio"}
	#validates :code, length: {minimum: 5, maximum: 10, :message => "El Detalle debe tener minimo 5 y maximo 10 caracteres"}

	#validates :description, presence: {:message => "Es un campo obligatorio"}
	#validates :description, length: {minimum: 10, maximum: 100, :message => "El Detalle debe tener minimo 5 y maximo 10 caracteres"}

	def cancelar_pedido
  		self.state = nil
  		self.order_id = nil      
    end
end
