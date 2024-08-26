class BooksController < ApplicationController
  include Pagy::Backend

  before_action :find_book, only: [ :show ]

  def index
    if params[:query].present?
      @books = Book.search_books(params[:query])
    else
      @books = Book.all
    end

    @pagy, @books = pagy(@books)
  end

  def show
  end

  private

  def find_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end
end
