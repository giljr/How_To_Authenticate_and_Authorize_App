class AddRoleToAdmin < ActiveRecord::Migration[8.0]
  def change
    add_reference :admins, :role, null: false, foreign_key: true
  end
end
