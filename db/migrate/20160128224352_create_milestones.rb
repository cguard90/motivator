class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.integer  :goal_id,     null: false, index: true
      t.string   :description, null: false, limit: 300
      t.date     :deadline,    null: false
      t.boolean  :completed,   default: false
      t.boolean  :confirmed,   default: false
      t.integer  :value

      t.timestamps             null: false
    end
  end
end
