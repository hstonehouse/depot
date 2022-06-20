class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    # a cart can have many line items
    # if a cart is destroyed, then also destroy the line items associated

    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        # find_by() will return an existing line item or nil
        if current_item
            current_item.quantity += 1
        else
            current_item = line_items.build(product_id: product.id)
            # new line item relationship between @cart object and product
        end
        current_item
    end

    def total_price
        line_items.to_a.sum { |item| item.total_price }
        # turns the line_items object into an array and returns the sum
    end
end



