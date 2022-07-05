require "test_helper"
require "pry"

class AddToCartTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "add_to_cart" do
    visit "/" # act
    add_to_cart(".product-3") # act
    assert_equal current_path, "/" # assert

    within('[data-qa="product-title"]') do
      assert_text 'Programming Ruby 1.9' # assert
    end
    within("#cart tbody .price") do
      assert text /\$[,\d]+\.\d\d/ # assert
    end
  end

  test "add multiple of same item to cart" do
    visit "/" # act
    add_to_cart(".product-3") # act

    visit "/" # act
    # now we need to specify ul.catalog because 
    # there is a cart partial on the sidenav,
    # so there are multiple places where you can find .product-3
    add_to_cart("ul.catalog .product-3") # act

    # there is only one place where you can specifically find .product-3.quantity
    line_item_quantity = find(".product-3.quantity").text
    assert_equal "2", line_item_quantity # assert
  end

  private
  def add_to_cart(product)
    within(product) do
        click_on('Add to Cart')
    end
  end
end
