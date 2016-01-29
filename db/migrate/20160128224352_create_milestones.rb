class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.integer     :goal_id,     null: false, index: true
      t.string      :description, null: false
      t.date        :deadline,    null: false

      t.timestamps                null: false
    end
  end
end
