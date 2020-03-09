class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :text
      t.string :image
      t.timestamps
    end
  end
end
