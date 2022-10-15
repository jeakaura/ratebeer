class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }

  def self.top(maks = 3)
    sorted_by_rating_in_desc_order = Beer.all.sort_by(&:average_rating).reverse
    sorted_by_rating_in_desc_order.first(maks)
  end

  # Palauttaa oluen tiedot muodossa "OluenNimi (PanimonNimi)"
  def to_s
    a = name
    b = brewery.name
    "#{a} (#{b})"
  end
end
