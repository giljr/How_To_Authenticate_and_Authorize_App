class Permission < ApplicationRecord
    has_many :permission_roles, dependent: :destroy
end
