class Order < ActiveRecord::Base
	attr_accessible :numero_pedido, :provider_id, :estado, :ingresado, :confirm
	
  belongs_to :providers
  
  has_many :productorders	

	def correspondeAproveedor(proveedor)
    	parametros = proveedor.split(' ')
    	parametros.each do |parametro|
      	if Provider.find(self.provider_id.to_i).name.downcase.include?(parametro.downcase)
	        return true
    	  end
    	end
    	false
  	end

end
