class RolesController < ApplicationController
    before_action :authenticate_admin!
    before_action :find_role, only: [:edit, :update, :destroy, :permissions, :store_permissions]
    # before_action :find_role, only: %i[edit update destroy permissions store_permissions]
    before_action :fetch_permissions, only: [:permissions]

  
    def index
      @roles = Role.all
    end
  
    def new
      @role = Role.new
    end
  
    def create
      @role = Role.new(role_params)
      if @role.save
        flash[:notice] = 'Role created successfully'
        redirect_to roles_path
      else
        flash.now[:alert] = @role.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit; end
  
    def update
      if @role.update(role_params)
        flash[:notice] = 'Role updated successfully'
        redirect_to roles_path
      else
        flash.now[:alert] = @role.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @role.destroy
        flash[:notice] = 'Role deleted successfully'
      else
        flash[:notice] = @role.errors.full_messages.join(",")
      end
      redirect_to roles_path
    end
  
    def permissions
      @select_permission_ids = @role.permissions.ids
    end
  
    def store_permissions
      @role.permission_ids = params[:permission_ids]
      flash[:notice] = 'Permissions were assigned successfully!'
      redirect_to roles_path
    end
  
    def fetch_permissions
      @permissions = Permission.all
    end

    def Permissions
      @select_permission_ids = @role.permissions.ids
    end

    def store_permissions
      @role.permission_ids = params[:permission_ids]
      flash[:notice] = 'Permissions were assigned successfully!'
      redirect_to roles_path
    end

    def fetch_permissions
      @permissions = Permission.all
    end

    private
  
    def role_params
      params.require(:role).permit(:name)
    end
  
    def find_role
      @role = Role.find_by(id: params[:id])
      unless @role
        flash[:alert] = "Role not found!"
        redirect_to roles_path
      end
    end
  end
  