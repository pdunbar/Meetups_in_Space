class ModifyAttendeeCreatorAndTimestamps < ActiveRecord::Migration
  def up
    change_column :attendees, :creator, :boolean, default: false
    change_table :attendees do |t|
      t.timestamps
    end
  end

  def down
    change_column :attendees, :creator, :boolean
    remove_column :attendees, :created_at
    remove_column :attendees, :updated_at
  end

end
