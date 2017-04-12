class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :pay_with, only: [:pay_with_alipay, :pay_with_wechat]


  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save

      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end
      current_cart.clean!
      OrderMailer.notify_order_placed(@order).deliver!

      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end


  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists

  end

 def pay_with_alipay


   redirect_to order_path(@order.token), notice: "使用支付宝成功完成付款"
 end

 def pay_with_wechat


   redirect_to order_path(@order.token), notice: "使用微信支付成功完成付款"
 end

 def apply_to_cancel
   @order = Order.find(params[:id])
   OrderMailer.apply_cancel(@order).deliver!
   flash[:notice] = "已提交申请"
   redirect_to :back
 end





  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end

end
