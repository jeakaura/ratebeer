require 'rails_helper'

describe "Places" do
  it "jos API palauttaa yhden, se näytetään sivulla" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 )  ]
    )

    stub_request(:get, "http://api.weatherstack.com/current?access_key=&query=kumpula").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: '{"request":{"type":"City","query":"Kumpula, Finland","language":"en","unit":"m"},"location":{"name":"Kumpula","country":"Finland","region":"Lapland","lat":"66.667","lon":"27.583","timezone_id":"Europe\/Helsinki","localtime":"2022-10-11 17:31","localtime_epoch":1665509460,"utc_offset":"3.0"},"current":{"observation_time":"02:31 PM","temperature":8,"weather_code":122,"weather_icons":["https:\/\/assets.weatherstack.com\/images\/wsymbols01_png_64\/wsymbol_0004_black_low_cloud.png"],"weather_descriptions":["Overcast"],"wind_speed":22,"wind_degree":196,"wind_dir":"SSW","pressure":1002,"precip":0,"humidity":84,"cloudcover":100,"feelslike":4,"uv_index":2,"visibility":10,"is_day":"yes"}}', headers: {})

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "jos API ei löydä paikkakunnalta yhtään olutpaikkaa, sivulla näytetään ilmoitus" do
    allow(BeermappingApi).to receive(:places_in).with("kuokkala").and_return([])

    stub_request(:get, "http://api.weatherstack.com/current?access_key=&query=kuokkala").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: '{"request":{"type":"City","query":"Kuokkala, Finland","language":"en","unit":"m"},"location":{"name":"Kumpula","country":"Finland","region":"Lapland","lat":"66.667","lon":"27.583","timezone_id":"Europe\/Helsinki","localtime":"2022-10-11 17:31","localtime_epoch":1665509460,"utc_offset":"3.0"},"current":{"observation_time":"02:31 PM","temperature":8,"weather_code":122,"weather_icons":["https:\/\/assets.weatherstack.com\/images\/wsymbols01_png_64\/wsymbol_0004_black_low_cloud.png"],"weather_descriptions":["Overcast"],"wind_speed":22,"wind_degree":196,"wind_dir":"SSW","pressure":1002,"precip":0,"humidity":84,"cloudcover":100,"feelslike":4,"uv_index":2,"visibility":10,"is_day":"yes"}}', headers: {})


    visit places_path
    fill_in('city', with: 'kuokkala')
    click_button "Search"

    expect(page).to have_content "No locations in kuokkala"
  end

  it "jos API palauttaa useita olutpaikkoja, kaikki näistä näytetään sivulla" do
    allow(BeermappingApi).to receive(:places_in).with("kortepohja").and_return(
        [ Place.new( name: "Kierre", id: 1 ), Place.new( name: "Ale Pub", id: 2 )  ]
    )

    stub_request(:get, "http://api.weatherstack.com/current?access_key=&query=kortepohja").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: '{"request":{"type":"City","query":"Kortepohja, Finland","language":"en","unit":"m"},"location":{"name":"Kumpula","country":"Finland","region":"Lapland","lat":"66.667","lon":"27.583","timezone_id":"Europe\/Helsinki","localtime":"2022-10-11 17:31","localtime_epoch":1665509460,"utc_offset":"3.0"},"current":{"observation_time":"02:31 PM","temperature":8,"weather_code":122,"weather_icons":["https:\/\/assets.weatherstack.com\/images\/wsymbols01_png_64\/wsymbol_0004_black_low_cloud.png"],"weather_descriptions":["Overcast"],"wind_speed":22,"wind_degree":196,"wind_dir":"SSW","pressure":1002,"precip":0,"humidity":84,"cloudcover":100,"feelslike":4,"uv_index":2,"visibility":10,"is_day":"yes"}}', headers: {})

    
    visit places_path
    fill_in('city', with: 'kortepohja')
    click_button "Search"

    expect(page).to have_content "Kierre"
    expect(page).to have_content "Ale Pub"
  end
end
