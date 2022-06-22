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
    assert_equal current_path, "/cart" # assert
  end

  test "add multiple of same item to cart" do
    visit "/" # act
    within(".product-3") do
      click_on('Add to Cart') # act
    end

    visit "/" # act
    within(".product-3") do
      click_on('Add to Cart') # act
    end
    line_item_quantity = find(".product-3.quantity").text
    assert_equal "2", line_item_quantity # assert
  end
end
