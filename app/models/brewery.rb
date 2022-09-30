class Brewery < ApplicationRecord
    include RatingAverage

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers
  
    # Tulostaa panimoraportin.
    def print_report
      puts name
      puts "established at year #{year}"
      puts "number of beers #{beers.count}"
    end

    # "Käynnistää" panimon uudelleen vuodesta 2022
    def restart
        year = 2022
        puts "changed year to #{year}"
    end
end
