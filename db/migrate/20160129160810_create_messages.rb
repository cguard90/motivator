class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :goal_id,     null: false
      t.integer :user_id,     null: false
      t.string :content,      null: false, limit: 140

      t.timestamps null: false
    end
  end
end
