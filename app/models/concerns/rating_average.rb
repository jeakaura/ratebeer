module RatingAverage
  extend ActiveSupport::Concern

  # Laskee arvosteluiden keskiarvon.
  def average_rating
    return 0 if ratings.empty?

    ratings.average(:score).round(1)
  end

  # Laskee arvosteluiden lukumäärän.
  def ratings_count
    ratings.count
  end
end
