require 'rails_helper'

describe "Panimot" do
  it "ei pitäisi olla yhtäkään panimoa, jos niitä ei ole luotu" do
    visit breweries_path
    expect(page).to have_content 'Breweries'
    expect(page).to have_content 'Number of breweries: 0'

  end

  describe "kun panimoita on luotu" do
    before :each do
      # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it "listaa panimot ja niiden määrät yhteensä" do
      expect(page).to have_content "Number of breweries: #{@breweries.count}"
      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "mahdollista siirtyä panimon sivulle" do
      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established in 1897"
    end

  end
end
