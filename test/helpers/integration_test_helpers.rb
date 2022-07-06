module IntegrationTestHelpers
    private
    def change_quantity(button_css_class, submit_value)
        within(button_css_class) do
            click_on(submit_value)
        end
    end

    def add_to_cart_using_button(product)
        find("[data-qa='button-product-#{product.id}']").click
    end

    def add_to_cart_using_image(product)
        find("[data-qa='image-product-#{product.id}']").click
    end

end