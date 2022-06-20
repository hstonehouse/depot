class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # we don't need the total_price method anymore because we have a total_price column in the line items table now
end
