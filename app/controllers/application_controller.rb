class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:penname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:penname])
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
