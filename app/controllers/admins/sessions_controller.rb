# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = Admin.find_for_database_authentication(email: params[:admin][:email])

    if resource && resource.valid_password?(params[:admin][:password])
      sign_in(resource_name, resource)
      set_flash_message!(:notice, :signed_in)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      if resource && !resource.super_admin?
        remain_attempts = (Admin.maximum_attempts - resource.failed_attempts) - 1
        if(remain_attempts <= 0)
          super
        else
          resource.update failed_attempts: (resource.failed_attempts + 1)
          flash[:alert] = "Invalid Email or Password. You have #{remain_attempts} more login attempts. After that your account will be locked!"
        end
      else
        flash[:alert] = "Invalid Email or Password"
      end
      redirect_to new_admin_session_path
    end
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
