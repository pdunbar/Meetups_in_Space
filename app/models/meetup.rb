class Meetup < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :attendees

end
