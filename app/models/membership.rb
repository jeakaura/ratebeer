class Membership < ApplicationRecord
  validates :beer_club_id, uniqueness: { scope: :user_id, message: "Et voi liittyä monikertaisesti yhteen seuraan." }
  belongs_to :beer_club
  belongs_to :user
end
