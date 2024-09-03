class BooksController < ApplicationController
  include Pagy::Backend
  include FindBook

  before_action :find_book, only: [ :show ]

  def index
    if params[:query].present?
      @books = Book.search_books(params[:query])
    else
      @books = Book.all
    end

    @books = @books.with_attached_image
    @pagy, @books = pagy(@books)
  end

  def show
    @reviews = @book.reviews
    rating = params[:rating].to_i
    if rating.between?(1, 5)
      @reviews = @reviews.where(rating: rating)
      @filtered = true
    end
    @reviews = @reviews.ordered.eager_load(:user, :votes)

    @pagy, @reviews = pagy(@reviews)
  end
end
