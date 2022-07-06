require "test_helper"
require "pry"

class DecrementLineItemTest < ActionDispatch::IntegrationTest
    include IntegrationTestHelpers

    test "decrement_line_item_quantity: when quantity = 1 and it's the only line item" do
        product = products(:rails) # arrange

        visit "/" # act
        
        2.times do
            add_to_cart(".catalog .product-#{product.id}")  # act
        end

        change_quantity("#cart .product-#{product.id}.minus-button", "-") # act
    
        line_item_quantity = find(".product-#{product.id}.quantity").text
        assert_equal "1", line_item_quantity # assert

        change_quantity("#cart .product-#{product.id}.minus-button", "-")
        
        assert find("#cart", visible: false) # assert that we can find the cart but can't see it
    end
end
