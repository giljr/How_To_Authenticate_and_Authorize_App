class ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_product, only: [:edit, :update,:destroy]
  
    def index
      authorize current_admin, :view_product?, policy_class: ProductPolicy
      @products = Product.all
    end
  
    def new
      authorize current_admin, :create_product?, policy_class: ProductPolicy
      @product = Product.new
    end
  
    def create
      authorize current_admin, :create_product?, policy_class: ProductPolicy
      @product = Product.new(product_params)
      if @product.save
        flash[:notice] = 'Product created successfully'
        redirect_to products_path
      else
        flash[:notice] = @product.errors.full_messages.join(",")
        redirect_to new_product_path
      end
    end
  
    def edit
      authorize current_admin, :update_product?, policy_class: ProductPolicy
    end
  
    def update
      authorize current_admin, :update_product?, policy_class: ProductPolicy
      if(@product.update(product_params))
        flash[:notice] = 'Product updated successfully'
        redirect_to products_path
      else
        flash[:notice] = @product.errors.full_messages.join(",")
        redirect_to product_path(@product)
      end
    end
  
    def destroy
      authorize current_admin, :delete_product?, policy_class: ProductPolicy
      if @product.destroy
        flash[:notice] = 'Product deleted successfully'
      else
        flash[:notice] = @product.errors.full_messages.join(",")
      end
      redirect_to products_path
    end
  
    private
  
    def find_product
      @product = Product.find_by id: params[:id]
      unless @product
        flash[:notice] = "Product not found!!!"
        redirect_to products_path
      end
    end
  
    def product_params
      params.require(:product).permit(:name, :price, :sku)
    end
end
