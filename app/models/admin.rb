class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable

         enum :admin_type, [:super_admin, :customer, :staff_user]
         belongs_to :role, optional: true

         before_save :manage_role

         def manage_role
            if self.customer?
              self.role_id = 1
            end
          end
  
end
