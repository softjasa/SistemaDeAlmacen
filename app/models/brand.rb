class Brand < ActiveRecord::Base
  attr_accessible :name

  has_many :productnames, :dependent => :destroy

  validates :name, presence: {:message => "Usted debe ingresar el nombre de la marca"}  
  validates :name, uniqueness: {case_sensitive: false, :message => "La marca ya existe"}
  validates :name, format: { with: /\A[a-zA-Z\d\s]+\z/,
    message: "Solo Letras Permitidas" }

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
