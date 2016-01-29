class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username,  null: false, unique: true, limit: 20
      t.string  :email,     null: false, unique: true
      t.string  :password_digest, null: false

      t.string  :provider
      t.string  :uid

      t.timestamps  null: false
    end
  end
end
