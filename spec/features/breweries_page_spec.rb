require 'rails_helper'

describe "Panimot" do
  it "ei pitäisi olla yhtäkään panimoa, jos niitä ei ole luotu" do
    visit breweries_path
    expect(page).to have_content 'Listing breweries'
    expect(page).to have_content 'Number of active breweries: 0'

  end
end
