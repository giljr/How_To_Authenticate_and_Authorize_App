class DashboardController < ApplicationController
    before_action :authenticate_admin!, only: [:lock_accounts, :unlock_accounts]
    before_action :check_access, only: [:lock_accounts, :unlock_accounts]
  
    def index
    end
  
    def lock_accounts
      @admins = Admin.where.not(unlock_token: nil)
    end
  
    def unlock_accounts
      admin = Admin.find_by(id: params[:id])
  
      if admin
        admin.update(
          failed_attempts: 0,
          unlock_token: nil,
          locked_at: nil
        )
        flash[:notice] = 'Account has been unlocked successfully!'
      else
        flash[:notice] = 'User not found'
      end
  
      redirect_to lock_accounts_path
    end
  
    private
  
    def check_access
      unless current_admin.super_admin?
        flash[:notice] = 'You are not authorized to perform this action!'
        redirect_to root_path
      end
    end
  end
  