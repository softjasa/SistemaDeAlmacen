class CreateProductnames < ActiveRecord::Migration
  def change
    create_table :productnames do |t|
    	t.string :name
    	t.string :code
    	t.string :description
    	t.integer :brand_id
      t.timestamps
    end
  end
end