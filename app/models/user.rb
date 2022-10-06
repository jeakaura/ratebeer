class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  validates :username, uniqueness: true,
                       length: 3..30

  validates :password,  length: { minimum: 4 },
                        format: /(?=.*[A-Z]).+(?=.*\d).+/

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    beers.group(:style).order("sum_score desc").sum(:score).keys[0]
  end

  def favorite_brewery
    return nil if ratings.empty?

    beers.group(:brewery).order("count_brewery_id desc").count("brewery_id").keys[0]
  end
end
