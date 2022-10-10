require 'rails_helper'

describe "BeermappingApi" do
  it "Kun HTTP GET palauttaa yhden paikan, se parsitaan ja palautetaan" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*turku/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("turku")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Panimoravintola Koulu")
    expect(place.street).to eq("Eerikinkatu 18")
  end

  it "HTTP GET ei palauta yhtään paikkaa, joten tyhjä taulukko" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING
    
    stub_request(:get, /.*lahti/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    
    places = BeermappingApi.places_in("lahti")

    expect(places.size).to eq(0)
  end

  it "HTTP GET palauttaa useita paikkoja, ja kaikki place-olioina" do
    
    canned_answer = <<-END_OF_STRING
    <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>1</id><name>Pub Kierre</name></location><location><id>2</id><name>Freetime</name></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*jkl/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    
    places = BeermappingApi.places_in("jkl")

    expect(places.size).to eq(2)
    place = places.first
    expect(place.name).to eq("Pub Kierre")
    place = places.last
    expect(place.name).to eq("Freetime")
  end

end