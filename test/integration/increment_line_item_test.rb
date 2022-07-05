require "test_helper"
require "pry"

class IncrementLineItemTest < ActionDispatch::IntegrationTest
    test "increment existing line item by 1" do
        product = products(:rails) # arrange

        visit "/" # act

        add_to_cart(".catalog .product-#{product.id}") # act
        increment_quantity("#cart .product-#{product.id}.plus-button")

        line_item_quantity = find(".product-#{product.id}.quantity").text
        assert_equal "2", line_item_quantity # assert
        
        line_item_total_price = find("#cart tbody .price").text
        assert_equal "$3,200.00", line_item_total_price # assert
    end

    private
    def increment_quantity(product)
        within(product) do
            click_on("+")
        end
    end

    def add_to_cart(product)
        within(product) do
            click_on('Add to Cart')
        end
    end
end