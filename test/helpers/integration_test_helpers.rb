module IntegrationTestHelpers
    private
    def change_quantity(button_css_class, submit_value)
        within(button_css_class) do
            click_on(submit_value)
        end
    end

    def add_to_cart(product)
        within(product) do
            click_on('Add to Cart')
        end
    end

end