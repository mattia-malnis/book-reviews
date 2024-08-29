module FindBook
  extend ActiveSupport::Concern

  included do
    before_action :find_book
  end

  private

  def find_book
    @book = Book.find(params[:book_id] || params[:id])
  end
end
