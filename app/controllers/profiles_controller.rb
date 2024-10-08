class ProfilesController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!

  def show
    @reviews = current_user.reviews.ordered.eager_load(:book)
    @pagy, @reviews = pagy(@reviews)
  end
end
