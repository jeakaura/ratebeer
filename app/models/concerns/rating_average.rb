module RatingAverage
  extend ActiveSupport::Concern

  # Laskee arvosteluiden keskiarvon.
  def average_rating
    # tehdään laskelmat muistiin haettujen olueen liittyvien ratings-olioiden avulla
    rating_count = ratings.size

    return 0 if rating_count == 0

    ratings.map(&:score).sum / rating_count
  end

  # Laskee arvosteluiden lukumäärän.
  def ratings_count
    ratings.count
  end
end
