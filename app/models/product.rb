class Product < ActiveRecord::Base
	has_many :subproducts, dependent: :destroy
	has_many :incomes
    
	attr_accessible :name, :detail, :description, :increase, :id_order, :quantity, :general_code, :brand, :category, :bought_price, :created_at, :updated_at, :photo
    has_one :kardex


	belongs_to :sale
	has_many :brands
	has_many :categories

	#has_attached_file :photo
	#validates_attachment_size :photo, :less_than => 5.megabytes
	#validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
	#validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']


	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" },
		:storage => :dropbox,
    	:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
	 	:default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/



	validates :brand, presence: true

	validates :name, presence: {:message => "Es un campo obligatorio"}
	validates :general_code, uniqueness: {case_sensitive: false, :message => "El codigo ya existe"}	

	validates :name, length: {minimum: 2, maximum: 20, :message => "El Nombre debe tener entre 2 y 20 caracteres"}

	validates :detail, presence: {:message => "Es un campo obligatorio"}
	validates :detail, length: {minimum: 10, maximum: 100, :message => "El Detalle debe tener entre 10 y 30 caracteres"}

	validates :general_code, presence: {:message => "Es un campo obligatorio"}
	validates :general_code, length: {minimum: 2, maximum: 15, :message => "El Codigo general debe tener entre 2 y 15 caracteres"}

	validates :bought_price, numericality: {greater_than: -1, :message => "El costo no puede ser negativo" }

	#validates :description, presence: {:message => "Es un campo obligatorio"}
	#validates :name, length: {minimum: 2, maximum: 20, :message => "La Descripcion debe tener minimo 2 y maximo 20 caracteres"}

	after_create :crear_subproducto

	def registrar(productorder)
		@productname = Productname.find(productorder.productname_id.to_i)
		self.name = @productname.name
	  	self.detail = @productname.description
	  	self.id_order = productorder.order_id
	  	self.general_code = @productname.code
	  	self.brand = Brand.find(@productname.brand_id).name
	  	self.category = "Categoria no asignada"
	  	self.bought_price = productorder.price
	end

	def crear_subproducto
#		subproducts.create("code" => general_code+"-0")
		i = 0
		while i < self.quantity do
      		self.subproducts.create("code" => self.general_code + "-#{i}", "name" => self.name)
      		i = i + 1
    	end
    	self.increase = 0
    	self.save
	end

	def correspondeAnombre(nombre)
    	parametros = nombre.split(' ')
    	parametros.each do |parametro|
      	if self.name.downcase.include?(parametro.downcase)
	        return true
    	  end
    	end
    	false
  	end

	def correspondeApagina(nombre)
    	parametros = nombre.split(' ')
    	parametros.each do |parametro|
      	if self.name.downcase.include?(parametro.downcase)
	        return true
    	  end
    	end
    	false
  	end

  	def correspondeAcategoria(categoria)
      	if self.category.downcase.include?(categoria.downcase)
	        return true
    	  end
    	false
  	end

	before_create do
		self.increase = 0
	end

	def disminuir
		self.quantity -= 1
	end

	def aumentar
		self.quantity += 1
	end
end
