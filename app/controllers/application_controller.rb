class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit::Authorization

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def admin_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # Authorization context will be the current admin
  # This is used by Pundit to determine the current user for authorization
  # This is a custom method that returns the current admin user
  # It is used by Pundit to determine the current user for authorization
  # It is defined in the ApplicationController so it can be used in all controllers
  # that inherit from ApplicationController
  # It is also used by Devise to determine the current user for authentication
  # It is defined in the ApplicationController so it can be used in all controllers
  # that inherit from ApplicationController

  private
  
  def pundit_user
    current_admin
  end
  
end
