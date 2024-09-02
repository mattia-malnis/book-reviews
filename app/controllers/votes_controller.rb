class VotesController < ApplicationController
  include FindReview

  before_action :authenticate_user!

  def toggle_vote
    vote_type = "vote_#{params[:vote_type]}".to_sym
    Vote.transaction do
      vote = Vote.send(vote_type).find_by(user: current_user, review: @review)
      if vote.present?
        vote.destroy!
      else
        Vote.send(vote_type).create!({ user: current_user, review: @review })
      end

      # Update counter on review
      @review.send("update_#{params[:vote_type]}_counter")
    end

    respond_to do |format|
      format.html { redirect_to @review.book }
      format.turbo_stream
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed => e
    flash[:alert] = "There was an error processing your vote: #{e.message}"
    redirect_to @review.book
  end
end
