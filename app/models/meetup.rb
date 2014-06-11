class Meetup < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

  has_many :attendees
  has_many :users, through: :attendees

end
