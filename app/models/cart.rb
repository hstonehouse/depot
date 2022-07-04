class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    # a cart can have many line items
    # if a cart is destroyed, then also destroy the line items associated

    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        # find_by() will return an existing line item or nil
        if current_item
            current_item.quantity += 1
            current_item.total_price = product.price * current_item.quantity
        else
            current_item = line_items.build(product_id: product.id, total_price: product.price)
            # new line item relationship between @cart object and product
        end
        current_item
    end

    def decrement_line_item_quantity(line_item)
        if line_item.quantity > 1
            line_item.quantity -= 1
            line_item.total_price = line_item.product.price * line_item.quantity
        else
            line_item.delete
            if line_items.empty? # we are in the cart model so we don't have to write cart.line_items
                destroy # we are in the cart model so we are in the cart
            end
        end
        line_item
    end

    def total_price
        line_items.to_a.sum { |item| item.total_price }
        # turns the line_items object into an array using 'to_a'
        # the sum() method accepts a block
    end
end



