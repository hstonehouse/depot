class CreateProducts < ActiveRecord::Migration[6.1]
  def change # gives you db:migrate and db:rollback
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
