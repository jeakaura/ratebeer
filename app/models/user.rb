class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  validates :username, uniqueness: true,
                       length: 3..30

  validates :password,  length: { minimum: 4 },
                        format: /(?=.*[A-Z]).+(?=.*\d).+/
end
