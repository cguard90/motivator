class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer  :setter_id,    null: false, index: true
      t.integer  :tender_id,    null: false, index: true
      t.integer  :charity_id,   null: false, index: true
      t.string   :title,        null: false, limit: 60
      t.string   :description,  null: false, limit: 300
      t.decimal  :setter_pledge,   null: false, precision: 8, scale: 2

      t.timestamps              null: false
    end
  end
end
