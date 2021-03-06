require "test_helper"
require "pry"

class IncrementLineItemTest < ActionDispatch::IntegrationTest
    include IntegrationTestHelpers

    test "increment existing line item by 1" do
        product = products(:rails) # arrange

        visit "/" # act

        add_to_cart_using_button(product) # act
        increment(product)

        line_item_quantity = find(".product-#{product.id}.quantity").text
        assert_equal "2", line_item_quantity # assert

        line_item_total_price = find("#cart tbody .price").text
        assert_equal "$3,200.00", line_item_total_price # assert
    end
end