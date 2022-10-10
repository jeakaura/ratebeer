require 'rails_helper'

describe "Places" do
  it "jos API palauttaa yhden, se näytetään sivulla" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 )  ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "jos API ei löydä paikkakunnalta yhtään olutpaikkaa, sivulla näytetään ilmoitus" do
    allow(BeermappingApi).to receive(:places_in).with("kuokkala").and_return([])

    visit places_path
    fill_in('city', with: 'kuokkala')
    click_button "Search"

    expect(page).to have_content "No locations in kuokkala"
  end

  it "jos API palauttaa useita olutpaikkoja, kaikki näistä näytetään sivulla" do
    allow(BeermappingApi).to receive(:places_in).with("kortepohja").and_return(
        [ Place.new( name: "Kierre", id: 1 ), Place.new( name: "Ale Pub", id: 2 )  ]
    )
    
    visit places_path
    fill_in('city', with: 'kortepohja')
    click_button "Search"

    expect(page).to have_content "Kierre"
    expect(page).to have_content "Ale Pub"
  end
end
