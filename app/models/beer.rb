class Beer < ApplicationRecord
    include RatingAverage

    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    # Palauttaa oluen tiedot muodossa "OluenNimi (PanimonNimi)"
    def to_s
        a = name
        b = brewery.name
        return a + " (" + b + ")"
    end
end
