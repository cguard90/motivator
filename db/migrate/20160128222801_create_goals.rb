class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer  :setter_id,    null: false, index: true
      t.integer  :tender_id,    null: false, index: true
      t.integer  :charity_id,   null: false, index: true
      t.string   :title,        null: false, limit: 60
      t.string   :description,  null: false, limit: 300
      t.integer  :setter_pledge,   null: false
      t.boolean  :notification,   default: false
      t.boolean  :accepted,   default: false

      t.timestamps              null: false
    end
  end
end
