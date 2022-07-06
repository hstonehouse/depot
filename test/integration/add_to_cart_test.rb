require "test_helper"
require "pry"

class AddToCartTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  setup do
    @product = products(:ruby)
  end
  
  test "add to cart by clicking add to cart button" do
    visit "/" # act
    add_to_cart_using_button(@product) # act
    assert_equal current_path, "/" # assert

    within('[data-qa="product-title"]') do
      assert_text 'Programming Ruby 1.9' # assert
    end
    within("#cart tbody .price") do
      assert text /\$[,\d]+\.\d\d/ # assert
    end
  end

  test "add to cart by clicking product image" do
    visit "/" # act
    add_to_cart_using_image(@product) # act

    within('[data-qa="product-title"]') do
      assert_text 'Programming Ruby 1.9' # assert
    end
  end

  test "add multiple of same item to cart" do
    visit "/" # act
    add_to_cart_using_button(@product) # act

    visit "/" # act
    add_to_cart_using_button(@product) # act

    # there is only one place where you can specifically find .product-3.quantity
    line_item_quantity = find(".product-3.quantity").text
    assert_equal "2", line_item_quantity # assert
  end

end
