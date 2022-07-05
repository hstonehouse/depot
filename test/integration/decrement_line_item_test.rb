require "test_helper"
require "pry"

class DecrementLineItemTest < ActionDispatch::IntegrationTest

    test "decrement_line_item_quantity: when quantity = 1 and it's the only line item" do
        product = products(:rails) # arrange

        visit "/" # act
        
        add_to_cart(".catalog .product-#{product.id}") # act
        add_to_cart(".catalog .product-#{product.id}") # act

        decrement_quantity("#cart .product-#{product.id}.remove-button") # act
    
        line_item_quantity = find(".product-#{product.id}.quantity").text
        assert_equal "1", line_item_quantity # assert

        decrement_quantity("#cart .product-#{product.id}.remove-button") 
        
        assert find("#cart", visible: false) # assert that we can find the cart but can't see it
    end

    private
    def decrement_quantity(product)
        within(product) do
            click_on("-")
        end
    end

    def add_to_cart(product)
        within(product) do
            click_on('Add to Cart')
        end
    end
end