class Attendee < ActiveRecord::Base
  validates :meetup, presence: true, uniqueness: {scope: :user}
  validates :user, presence: true
  validates :creator, inclusion: {in: [true, false]}

  belongs_to :user
  belongs_to :meetup

end
