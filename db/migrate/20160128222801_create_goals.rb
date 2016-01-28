class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string    :title,  null: false
      t.string    :description, null: false
      t.integer   :setter_id, null: false
      t.integer   :tender_id, null: false
      t.integer   :limit
      t.integer   :charity_id, null: false

      t.timestamps null: false
    end
  end
end
