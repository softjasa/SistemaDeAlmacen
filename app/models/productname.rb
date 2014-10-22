class Productname < ActiveRecord::Base

	attr_accessible :name, :code, :description, :brand_id
	
    belongs_to :brand

    has_many :productorders, :dependent => :destroy
    
    validates :name, presence: {:message => "Debe ingresar el nombre del producto"}	
	validates :name, uniqueness: {case_sensitive: false, :message => "El nombre ya existe"}
	#validates :name, format: { with: /\A[a-zA-Z\d\s]+\z/,
    #message: "Solo Letras Permitidas" }
    validates :name, length: {minimum: 5, :message => "Minimo 5 caracteres"}

    validates :code, presence: {:message => "Debe ingresar el codigo del producto"}	
	validates :code, uniqueness: {case_sensitive: false, :message => "El codigo ya existe"}
	validates :code, length: {minimum: 5, :message => "El codigo debe tener minimo 5 caracteres"}

    validates :description, presence: {:message => "Debe ingresar una descripcion"}   
    validates :description, length: {minimum: 10, :message => "Minimo 5 caracteres"}

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
