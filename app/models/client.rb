class Client < ActiveRecord::Base
	attr_accessible :name, :nit, :phone
	validates :name, presence: {:message => "Usted debe ingresar el nombre del cliente"}	
	validates :name, uniqueness: {case_sensitive: false, :message => "El cliente ya existe"}
    validates :name, length: {minimum: 7, maximum: 45, :message => "Nombre debe tener minimo 7 caracter"}
	validates :name, format: {:multiline => true, with: /^[a-zA-Z ]+$/, message: "Solo Letras Permitidas" }
    validates :name, format: {with: /\s/, :message => "Debe ingresar nombre y apellido" }

    validates :nit, presence: {:message => "Usted debe ingresar el NIT"}
    validates :nit, numericality: {:message => "El valor de NIT debe ser numerico"}
    validates :nit, uniqueness: {case_sensitive: false, :message => "El NIT ya existe"}
    validates :nit, length: {minimum: 7, :message => "Numero de NIT debe tener minimo 7 caracter"}

    validates :nit, numericality: {greater_than: 0, :message => "Numero de NIT no puede ser un numero negativo" }

    validates :phone, numericality: {:message => "El valor de telefono/celular debe ser numerico"}
    validates :phone, length: {minimum: 7, maximum: 8, :message => "Numero de telefono/celular debe tener minimo 7 y maximo 8 numeros"}
    validates :phone, numericality: {greater_than: 0, :message => "Numero de telefono/celular no puede ser un numero negativo" }

    def for_sale
        self.nit.to_s<<" "<<self.name
    end

    def correspondeAnombre(nombre)
        parametros = nombre.split
        parametros.each do |parametro|
        if self.name.downcase.include?(parametro.downcase)
            return true
          end
        end
        false
    end
end
