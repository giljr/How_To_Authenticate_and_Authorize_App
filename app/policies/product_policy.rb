class ProductPolicy < ApplicationPolicy
  attr_reader :admin, :record
  include ProductPermissions

  def initialize(admin, record)
    @admin = admin
    @record = record
  end

  def create_product?
    allowed?(ADD_PRODUCT)
  end

  def update_product?
    allowed?(EDIT_PRODUCT)
  end

  def delete_product?
    allowed?(DELETE_PRODUCT)
  end 

  def view_product?
    allowed?(VIEW_PRODUCT)
  end

  private

  def allowed?(permission_id)
    admin.super_admin? || admin.role.permission_ids.include?(permission_id)
  end
end
