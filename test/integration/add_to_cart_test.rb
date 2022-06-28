require "test_helper"
require "pry"

class AddToCartTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "add to cart" do
    visit "/" # act
    within(".product-3") do
      click_on('Add to Cart') # act
    end
    assert_equal current_path, "/" # assert
  end

  test "add multiple of same item to cart" do
    visit "/" # act
    within(".product-3") do
      click_on('Add to Cart') # act
    end

    visit "/" # act
    # now we need to specify ul.catalog because 
    # there is a cart partial on the sidenav,
    # so there are multiple places where you can find .product-3
    within("ul.catalog .product-3") do
      click_on('Add to Cart') # act
    end
    # there is only one place where you can specifically find .product-3.quantity
    line_item_quantity = find(".product-3.quantity").text
    assert_equal "2", line_item_quantity # assert
  end
end
