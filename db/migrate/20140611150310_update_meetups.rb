class UpdateMeetups < ActiveRecord::Migration
  def change
    remove_column :meetups, :user_id, :string
    add_column :attendees, :creator, :boolean
  end
end
