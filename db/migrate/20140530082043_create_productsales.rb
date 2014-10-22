class CreateProductsales < ActiveRecord::Migration
  def change
    create_table :productsales do |t|
 	  t.string :name
 	  t.string :code
 	  t.float :price
 	  t.integer :sale_id
 	  t.integer :subproduct_id
 	  t.string :client_name
      t.timestamps
    end
  end
end
