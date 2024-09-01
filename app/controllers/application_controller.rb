class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?

  unless Rails.env.production?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan
      yield
    ensure
      Prosopite.finish
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :nickname ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :nickname ])
  end

  def record_not_found
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end
end
