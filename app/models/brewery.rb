class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { only_integer: true,
                                   greater_than: 1039,
                                   less_than_or_equal_to: ->(_) { Time.now.year } }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  include RatingAverage

  def self.top(maks = 3)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by(&:average_rating).reverse
    sorted_by_rating_in_desc_order.first(maks)
  end
end
