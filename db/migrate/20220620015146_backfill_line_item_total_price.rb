class BackfillLineItemTotalPrice < ActiveRecord::Migration[6.1]
  def up
    # fill in the total_price column with product price * quantity
    LineItem.all.each do |line_item|
      line_item.total_price = line_item.product.price * line_item.quantity
    end
  end

  def down
    # remove data in the total_price column
  end
end
