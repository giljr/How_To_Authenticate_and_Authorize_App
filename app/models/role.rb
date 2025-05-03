class Role < ApplicationRecord
    has_many :admins
    has_many :permission_roles, dependent: :destroy
    has_many :permissions, through: :permission_roles
    validates :name, presence: true, uniqueness: true
end
