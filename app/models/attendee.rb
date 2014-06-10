class Attendee < ActiveRecord::Base
  validates :meetup_id, presence: true, uniqueness: {scope: :user}
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :meetup

end
