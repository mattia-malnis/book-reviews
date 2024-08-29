class Books::ReviewsController < ApplicationController
  include FindBook

  before_action :authenticate_user!
  before_action :find_review, only: [ :edit, :update ]
  before_action :authorize_user, only: [ :edit, :update ]

  def new
    @review = @book.reviews.new
  end

  def create
    @review = @book.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to(book_path(@book)) }
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
    @review = @book.reviews.find(params[:id])
  end

  def authorize_user
    unless @review.user_id == current_user.id
      redirect_to book_path(@book)
    end
  end
end
