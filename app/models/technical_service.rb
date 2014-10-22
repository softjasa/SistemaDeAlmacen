class TechnicalService < ActiveRecord::Base
	attr_accessible :product_code, :client, :status, :detail, :product_name, :problems, :repairs

	validates :detail, presence: {:message => "Es un campo obligatorio"}
	validates :detail, length: {minimum: 10, maximum: 100, :message => "El detalle debe tener entre 10 y 100 caracteres"}

	validates :problems, presence: {:message => "Es un campo obligatorio"}
	validates :problems, length: {minimum: 10, maximum: 100, :message => "Debe tener entre 10 y 100 caracteres"}

	validates :repairs, presence: {:message => "Es un campo obligatorio"}
	validates :repairs, length: {minimum: 10, maximum: 100, :message => "Debe tener entre 10 y 100 caracteres"}

	validates :product_name, presence: {:message => "Es un campo obligatorio"}
	validates :product_name, length: {minimum: 4, maximum: 20, :message => "El nombre del producto debe tener entre 4 y 20 caracteres"}

	validates :client, presence: {:message => "Es un campo obligatorio"}
	validates :client, length: {minimum: 3, maximum: 30, :message => "El cliente debe tener entre 3 y 30 caracteres"}

	validates :product_code, presence: {:message => "Es un campo obligatorio"}
	validates :product_code, length: {minimum: 5, maximum: 20, :message => "El Detalle debe tener entre 5 y 20 caracteres"}

	def correspondeACliente(nombre)
		texto = self.client.split
		texto.each do |palabra|
			if palabra.downcase.include?(nombre.downcase)
				return true
			end
		end
		false
	end
end
