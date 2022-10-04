class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  # Palauttaa oluen tiedot muodossa "OluenNimi (PanimonNimi)"
  def to_s
    a = name
    b = brewery.name
    "#{a} (#{b})"
  end
end
