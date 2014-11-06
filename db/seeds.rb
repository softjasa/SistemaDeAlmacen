# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	gerente = User.new
	gerente.username = 'gerente'
	gerente.name = 'gerente gerente'
	gerente.password = 'gerente123'
	gerente.rol = 'gerente'
	gerente.save!

	admin = User.new
	admin.username = 'admin'
	admin.name = 'Administrador Admin'
	admin.password = 'admin123'
	admin.rol = 'admin'
	admin.save!

	almacenero = User.new
	almacenero.username = 'encalmacen'
	almacenero.name = 'Almacen Alma'
	almacenero.password = 'almacen123'
	almacenero.rol = 'enc_almacen'
	almacenero.save!		


	brands = Brand.create([{name: "pil"}, {name: "fino"}, {name: "Don Vittorio"}, {name: "dillman"}, {name: "sofia"}, {name: "hass"}])
	categories = Category.create([{name: "vegetal"}, {name: "carne"}, {name: "lacteos"}, {name: "fruta"}, {name: "tuberculos"}, {name: "enlatados"}, {name: "pastas"}, {name: "guarnicion"}])
# Lista de Clientes

	

	client2 = Client.new
	client2.name = 'Juan Sabath'
	client2.nit = 212345353
	client2.phone = 3489101
	client2.save!

	
#Lista de proveedores

	

	#product names

	prodnames1 = Productname.new
	prodnames1.name = 'Leche'
	prodnames1.code = '01415'
	prodnames1.description = 'Leche pasteurizada'
	prodnames1.brand_id = 1
	prodnames1.save!
	



