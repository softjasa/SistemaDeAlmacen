class Provider < ActiveRecord::Base
	attr_accessible :name, :mail, :phone, :address
	
    has_many :orders, :dependent => :destroy

    validates :name, presence: {:message => "Usted debe ingresar el nombre de proveedor"}
	validates :name, uniqueness: {case_sensitive: false, :message => "El proveedor ya existe"}
	#validates :name, format: { with: /\A[a-zA-Z\d\s]+\z/,
    #message: "Solo Letras Permitidas" }

    validates :phone, numericality: {:message => "El valor de telefono/celular debe ser numerico"}
    validates :phone, length: {minimum: 7, maximum: 8, :message => "El numero de telefono/celular debe tener entre 7 y 8 digitos"}
    validates :phone, numericality: {greater_than: 0, :message => "El numero de telefono/celular no puede ser un numero negativo" }

    validates :address, presence: {:message => "Usted debe ingresar la direccion de proveedor"}
	#validates :address, format: { with: /\A[a-zA-Z\d\s]+\z/,:message => "Solo Letras Permitidas" } 
    validates :mail, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Formato no valido"}
    



	def correspondeAnombre(nombre)
    	parametros = nombre.split(' ')
    	parametros.each do |parametro|
      	if self.name.downcase.include?(parametro.downcase)
	        return true
    	  end
    	end
    	false
  	end

end
