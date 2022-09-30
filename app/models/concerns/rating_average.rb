module RatingAverage
    extend ActiveSupport::Concern
   
    # Laskee arvosteluiden keskiarvon.
    def average_rating
        return self.ratings.average(:score).round(1)
    end

    # Laskee arvosteluiden lukumäärän.
    def ratings_count
        return self.ratings.count
    end
end
