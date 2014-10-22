class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
    	t.string :name
    	t.integer :phone
    	t.string :mail
    	t.string :address
      t.timestamps
    end
  end
end
