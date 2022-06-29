require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success

    # We can't use assert_select anymore because this is minitest syntax,
      # and that has been overridden by capybara syntax in our test_helper
    # assert_select 'nav.side_nav a', minimum: 4
    # assert_select 'main ul.catalog li', 3

    # These have both moved to the add_to_cart integration test file
    # assert_select 'h2', 'Programming Ruby 1.9' 
    # assert_select '.price', /\$[,\d]+\.\d\d/

    # Now we have to use capybara syntax
    has_selector? 'nav.side_nav a'
    has_selector? 'main ul.catalog li'

  end
end
