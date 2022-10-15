class Style < ApplicationRecord
  include RatingAverage
  has_many :beers

  def self.top(maks = 3)
    Rating.joins(beer: :style).group("styles.text").order("average_score desc").limit(maks).average(:score)
  end
end
