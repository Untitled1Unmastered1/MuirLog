class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :date 
      t.string :creature 
      t.string :location
      t.string :coordinates
      t.text :description
      t.integer :user_id 
    end
  end
end
