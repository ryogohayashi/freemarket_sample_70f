class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :post_code, null: false
      t.string :prefecture_code, null: false
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :building
      t.string :phone_number
      t.references :user
      t.timestamps
    end
  end
end
