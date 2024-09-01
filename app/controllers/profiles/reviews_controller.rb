class Profiles::ReviewsController < ReviewsController
  private

  def after_update_path
    profile_path
  end
end
