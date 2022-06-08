class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
end

# a cart can have many line items
# if a cart is destroyed, then also destroy the line items associated
