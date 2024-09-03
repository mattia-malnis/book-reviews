class VotesController < ApplicationController
  include FindReview

  before_action :authenticate_user!
  before_action :validate_vote_type

  def toggle_vote
    Vote.transaction do
      vote = vote_class.find_by(user: current_user, review: @review)
      if vote.present?
        vote.destroy!
      else
        vote_class.create!({ user: current_user, review: @review })
      end

      update_review_counter
    end

    respond_to do |format|
      format.html { redirect_to @review.book }
      format.turbo_stream
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed => e
    flash[:alert] = "There was an error processing your vote: #{e.message}"
    redirect_to @review.book
  end

  private

  def vote_class
    case params[:vote_type]
    when "like" then Vote.vote_like
    when "dislike" then Vote.vote_dislike
    end
  end

  def update_review_counter
    case params[:vote_type]
    when "like" then @review.update_like_counter
    when "dislike" then @review.update_dislike_counter
    end
  end

  def validate_vote_type
    return if Vote.vote_types.keys.include?(params[:vote_type])

    raise ArgumentError, "Invalid vote type"
  end
end
