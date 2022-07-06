module IntegrationTestHelpers
    private
    def increment(product)
        find("[data-qa='product-#{product.id}-plus-button']").click
    end

    def decrement(product)
        find("[data-qa='product-#{product.id}-minus-button']").click
    end

    def add_to_cart_using_button(product)
        find("[data-qa='button-product-#{product.id}']").click
    end

    def add_to_cart_using_image(product)
        find("[data-qa='image-product-#{product.id}']").click
    end

end