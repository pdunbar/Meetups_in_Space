class CreateAttendeees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :user_id, null: false
      t.integer :meetup_id, null: false
    end
    add_index :attendees, [:user_id, :meetup_id], unique: true
  end
end
