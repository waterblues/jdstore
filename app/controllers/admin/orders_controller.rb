class Admin::OrdersController < AdminController

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "You are not admin."
    end
  end

  def index
    @orders = Order.order("id DESC")
    aasm_state_colors = { "order_placed" => '#FF6384',
                      "paid" => '#36A2EB',
                      "shipping" => 'rgba(255, 206, 86, 0.2)',
                      "shipped" => 'rgba(75, 192, 192, 0.2)',
                      "order_cancelled" => 'rgba(153, 102, 255, 0.2)',
                      "good_returned" => 'rgba(255, 159, 64, 0.2)'
                    }
     if @orders.any?
     dates = (@orders.first.created_at.to_date..Date.today).to_a
     @data = {
       labels: dates,
       datasets: Order::STATUS.map do |s|
         {
           :label => s,
           :data => dates.map{ |d|
             @orders.by_aasm_state(s).where( "created_at >= ? AND created_at <= ?", d.beginning_of_day, d.end_of_day).count
           },
           borderColor: aasm_state_colors[s]
         }
       end
     }
   end
 end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    OrderMailer.notify_ship(@order).deliver!
    redirect_to :back
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancell_order!
    OrderMailer.notify_cancel(@order).deliver!
    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end
end
