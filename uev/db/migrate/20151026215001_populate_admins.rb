class PopulateAdmins < ActiveRecord::Migration
  def change
    Admin.create(user: 'ylaguna', pass: '879')
  end
end
