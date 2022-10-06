require 'rails_helper'

include Helpers

describe "Arvostelu" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user, username: "Jorma" }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "kun annettu, rekisteröityy olueen ja kirjautuneena olevaan käyttäjään" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "kun luotu, näytetään yhteismäärä sivulla" do
    create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
    visit ratings_path
    expect(page).to have_content "Number of ratings: #{Rating.count}"
  end

  it "vain omat arvostelut näytetään omalla sivulla" do
    create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
    create_beers_with_many_ratings({user: user2}, 11, 21, 16, 17, 19)
    visit user_path(user)

    expect(page).to have_content "#{user.username} has made #{user.ratings.count}"
    expect(user.ratings.count).to eq(5)
    expect(Rating.count).to eq(10)
  end

  it "oma arvostelu poistuu" do
    create_beers_with_many_ratings({user: user}, 10)
    create_beers_with_many_ratings({user: user2}, 11, 21, 16, 17, 19)
    visit user_path(user)

    expect{
      click_button('delete')
    }.to change{user.ratings.count}.by(-1)
    expect(Rating.count).to eq(5)
  end

  it "näyttää lempparit" do
    create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
    visit user_path(user)

    expect(page).to have_content "Favorite Beer: #{user.favorite_beer}"
    expect(page).to have_content "Favorite Brewery: #{user.favorite_brewery.name}"
  end
end
