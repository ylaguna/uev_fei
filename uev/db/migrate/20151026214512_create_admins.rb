class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :user
      t.string :pass

      t.timestamps null: false
    end
  end
end
