class AddTotalPriceToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :total_price, :integer
  end
end
