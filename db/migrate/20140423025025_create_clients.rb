class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :nit
      t.integer :phone
      t.timestamps
    end
  end
end
