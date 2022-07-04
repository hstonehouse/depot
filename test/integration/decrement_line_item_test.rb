require "test_helper"
require "pry"

class DecrementLineItemTest < ActionDispatch::IntegrationTest

    test "decrement_line_item_quantity: when quantity = 1 and it's the only line item" do
        product = products(:rails) # arrange

        visit "/" # act
        
        within(".catalog .product-#{product.id}") do # act
            click_on('Add to Cart') 
            click_on('Add to Cart') # add to cart twice
        end

        within("#cart .product-#{product.id}.remove-button") do # act
            click_on("-") # remove once
        end 

        line_item_quantity = find(".product-#{product.id}.quantity").text
        assert_equal "1", line_item_quantity # assert

        within("#cart .product-#{product.id}.remove-button") do
            click_on("-")
        end 
        
        assert find("#cart", visible: false) # assert that we can find the cart but can't see it
    end
end