class Products::WishlistsController < ApplicationController
  before_action :set_product
  before_action :set_wishlist

  def create
    @wishlist.wishlist_products.create(product: @product)
    redirect_to @wishlist, notice: "#{@product.name} added to wishlist."
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_wishlist
      @wishlist = Current.user.wishlists.find(params[:wishlist_id])
    end
end
