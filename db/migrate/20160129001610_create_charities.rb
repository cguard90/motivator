class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string    :name,    null: false
      t.string    :type

      t.timestamps          null: false
    end
  end
end
