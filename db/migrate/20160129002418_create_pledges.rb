class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer  :user_id, null: false, index: true
      t.integer  :goal_id, null: false, index: true
      t.integer  :amount,  null: false

      t.timestamps         null: false
    end
  end
end
