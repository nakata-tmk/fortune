class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :email, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
