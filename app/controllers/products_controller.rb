class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :nonexistent_product

  # GET /products or /products.json
  def index
    @products = Product.all.order(:title)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        puts @product.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to store_index_url, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }

        # Broadcast product update via websocket
        @products = Product.all.order(:title)
        ActionCable.server.broadcast('products', 
          # the code below describes the html string we are sending to product_channel.js
          # we want to give it everything but the application.html (layout: false)
          {html: render_to_string('store/index', layout: false)} )
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end

    def nonexistent_product
      logger.error "Attempt to access non-existent product #{params[:id]}"
      redirect_to store_index_url, notice: 'Product does not exist'
    end
end
