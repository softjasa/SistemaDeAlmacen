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


	brands = Brand.create([{name: "Toshiba"}, {name: "Dell"}, {name: "Sony"}, {name: "3M"}, {name: "ASUS"}, {name: "Samsung"}, {name: "ViewSonic"}, {name: "Amazon"}, {name: "Apple"}, {name: "eBeam"}, {name: "Epson"}, {name: "BenQ"}, {name: "NEC"}, {name: "HP"}])
	categories = Category.create([{name: "Laptops"}, {name: "Maletines"}, {name: "Mochilas"}, {name: "Accesorios"}, {name: "Impresoras"}, {name: "Proyectores"}, {name: "Tablets"}, {name: "Mobiliarios"}])
# Lista de Clientes

	client1 = Client.new
	client1.name = 'Andres Martines'
	client1.nit = 2123344223
	client1.phone = 4489223
	client1.save!

	client2 = Client.new
	client2.name = 'Oscar Arce'
	client2.nit = 212345353
	client2.phone = 3489101
	client2.save!

	
#Lista de proveedores

	

	#product names

	prodnames1 = Productname.new
	prodnames1.name = 'toshiba-x10'
	prodnames1.code = 'tosh-x10'
	prodnames1.description = 'pantalla 17 pulgadas, teclado ingles, core i7 tercera generacion'
	prodnames1.brand_id = 1
	prodnames1.save!
	



