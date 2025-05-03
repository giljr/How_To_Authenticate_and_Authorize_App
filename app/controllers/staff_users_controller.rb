class StaffUsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :fetch_roles, only: [:new, :edit]
    before_action :find_staff_user, only: [:edit, :update, :destroy]
  
    # GET /staff_users
    def index
      @staff_users = Admin.staff_user
    end
  
    # GET /staff_users/new
    def new
      @staff_user = Admin.staff_user.new
    end
  
    # POST /staff_users
    def create
      @staff_user = Admin.staff_user.new(staff_user_params)
      if @staff_user.save
        flash[:success] = 'Staff user was successfully created.'
        redirect_to staff_users_path
      else
        flash.now[:notice] = @staff_user.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
        if @staff_user.update(staff_user_params)
            flash[:success] = 'Staff user was successfully updated.'
            redirect_to staff_users_path
        else
            flash.now[:notice] = @staff_user.errors.full_messages.join(", ")
            render :edit, status: :unprocessable_entity
        end
    end
  
    def destroy
      if @staff_user.destroy
        flash[:notice] = 'Staff user deleted successfully'
      else
        flash[:notice] = @staff_user.errors.full_messages.join(",")
      end
      redirect_to staff_users_path
    end

    private

    def find_staff_user
      @staff_user = Admin.staff_user.find_by(id: params[:id])
      unless @staff_user
        flash[:alert] = 'Staff user not found.'
        redirect_to staff_users_path and return
      end
    end
    
    
  
    def fetch_roles
      @roles = Role.where.not(id: 1).pluck(:name, :id)
    end
  
    def staff_user_params
      params.require(:staff_user).permit(
        :username, :email, :first_name, :last_name,
        :password, :password_confirmation, :role_id
      )
    end
  end
  