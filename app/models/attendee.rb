class Attendee < ActiveRecord::Base
  validates :meetup_id, presence: true, uniqueness: {scope: :user}
  validates :user_id, presence: true
  validates :creator, presence: true, inclusion: {in: [true, false]}

  belongs_to :user
  belongs_to :meetup

end
