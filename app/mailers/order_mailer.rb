class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  layout "mailer"

  def order_email(order)
    @order = order
    @line_items = LineItem.where(order_id: order.id)
    @user = User.where(email: order.email).first
    mail(to: @order.email, subject: "Email Reciept for Order ##{@order.id}")
  end
end