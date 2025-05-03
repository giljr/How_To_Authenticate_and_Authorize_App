module ApplicationHelper
    
    def is_authorize(admin, permission_id)
		admin.super_admin? || admin.role.permission_ids.include?(permission_id)
	end
end
