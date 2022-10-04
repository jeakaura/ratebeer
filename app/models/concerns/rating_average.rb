module RatingAverage
  extend ActiveSupport::Concern

  # Laskee arvosteluiden keskiarvon.
  def average_rating
    ratings.average(:score).round(1)
  end

  # Laskee arvosteluiden lukumäärän.
  def ratings_count
    ratings.count
  end
end
