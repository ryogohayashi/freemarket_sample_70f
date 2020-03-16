class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.references :brand
      t.references :condition
      t.references :postage_payer
      t.string :prefecture_code
      t.references :size
      t.references :preparation_day
      t.references :category
      t.boolean :trading_status
      t.references :user
      t.references :seller
      t.references :buyer
      t.timestamps
    end
  end
end
