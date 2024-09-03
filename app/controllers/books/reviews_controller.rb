class Books::ReviewsController < ReviewsController
  include FindBook

  def new
    @review = @book.reviews.new
  end

  def create
    @review = @book.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      @book.cache_ratings_average
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def after_update_path
    book_path(@book)
  end
end
