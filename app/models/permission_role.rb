class PermissionRole < ApplicationRecord
  belongs_to :role
  belongs_to :permission
end
