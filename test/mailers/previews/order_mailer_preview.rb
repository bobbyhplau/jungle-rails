
class OrderMailerPreview < ActionMailer::Preview
  def order_email

    OrderMailer.order_email
  end
end