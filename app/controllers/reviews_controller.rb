class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user = current_user

    if @review.save
      redirect_to :back
    else
      raise "You must be missing a rating or a description for your review."
    end
  end

 def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back
  end
end

def review_params
  params.require(:review).permit(
    :description, :rating
  )
end