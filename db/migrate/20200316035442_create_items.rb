class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.references :brand_id
      t.references :condition_id
      t.references :postage_payer_id
      t.string :prefecture_code
      t.references :size_id
      t.references :preparation_day_id
      t.references :category_id
      t.boolean :trading_status
      t.references :user
      t.references :seller_id
      t.references :buyer_id
      t.timestamps
    end
  end
end
