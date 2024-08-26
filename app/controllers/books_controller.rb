class BooksController < ApplicationController
  include Pagy::Backend

  def index
    if params[:query].present?
      @books = Book.search_books(params[:query])
    else
      @books = Book.all
    end

    @pagy, @books = pagy(@books)
  end
end
