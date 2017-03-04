class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :add_to_cart, :upvote]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end


  def show
  end


  def add_to_cart

    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title}加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
      redirect_to :back
  end


  def upvote
    @product.upvote_by current_user
    redirect_to :back
  end





end
