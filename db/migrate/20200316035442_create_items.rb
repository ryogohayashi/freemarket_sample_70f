class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.references :brand
      t.integer :condition_id
      t.integer :postage_payer_id
      t.string :prefecture_code
      t.integer :size_id
      t.integer :preparation_day_id
      t.references :category
      t.boolean :trading_status
      t.references :user
      t.references :seller
      t.references :buyer
      t.timestamps
    end
  end
end
