Role.create(name: "Customer")
Role.create(name: "SuperUser")

Admin.create(email: "admin@gmail.com", username: "admin", admin_type: 0, password: "password", password_confirmation: "password", role_id: 2)

Permission.create(name: "Can Add Produts")
Permission.create(name: "Can Edit Products")
Permission.create(name: "Can Delete Products")
Permission.create(name: "Can View Products")