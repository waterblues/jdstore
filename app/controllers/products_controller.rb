class ProductsController < ApplicationController


  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end


  def show
    @product = Product.find_by_friendly_id!(params[:id])

    set_page_title @product.title
    set_page_description "#{@product.description}"
  end


  def add_to_cart

    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title}加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end

  end


  def upvote
    @product = Product.find(params[:id])
    @product.upvote_by current_user
    redirect_to :back
  end





end
