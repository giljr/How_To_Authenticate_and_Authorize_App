class AccountsController < ApplicationController
    before_action :authenticate_admin!
  
    def confirm_deletion
    end
  
    def destroy
      current_admin.destroy
      sign_out current_admin
      flash[:notice] = "Your account has been successfully deleted. We hope to see you again soon."
      redirect_to root_path
    end
  end
  