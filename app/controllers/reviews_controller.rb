class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: [ :edit, :update ]
  before_action :authorize_user, only: [ :edit, :update ]

  def edit
  end

  def update
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to(after_update_path) }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def authorize_user
    unless @review.user_id == current_user.id
      redirect_to root_path
    end
  end

  # This method should be overridden in child controllers
  def after_update_path
    raise NotImplementedError, "#{self.class} must implement #after_update_path"
  end
end
