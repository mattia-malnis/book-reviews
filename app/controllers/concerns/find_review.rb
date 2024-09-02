module FindReview
  extend ActiveSupport::Concern

  included do
    before_action :find_review
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end
end
