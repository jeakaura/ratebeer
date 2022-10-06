require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "onko käyttäjätunnus asetettu oikein" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "ei tallennu ilman salasanaa" do
    user = User.create username: "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "ei tallennu liian lyhyellä salasanalla" do
    user = User.create username: "Pekka", password: "A1", password_confirmation: "A1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "ei tallennu pienikirjaimisella salasanalla" do
    user = User.create username: "Pekka", password: "secret1", password_confirmation: "secret1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "kunnollisella salasanalla" do
    let(:user) { FactoryBot.create(:user) }

    it "tallentuu" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "sekä kera kahden arvostelun, tulee oikea keskiarvo" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "suosikkiolut" do
    let(:user){ FactoryBot.create(:user) }

    it "metodi suosikkioluen määrittämiseen" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "ilman arvosteluja ei ole suosikkia" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "on ainoa arvosteltu, jos on vain yksi arvostelu" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "on korkeimmin arvosteltu, jos useampi arvostelu" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({user: user}, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "suosikkityyli" do
    let(:user){ FactoryBot.create(:user) }

    it "metodi suosikkityylin määrittämiseen" do
      expect(user).to respond_to(:favorite_style)
    end

    it "ilman arvosteluja ei ole suosikkityyliä" do
      expect(user.favorite_style).to eq(nil)
    end

    it "on suosikkityyli, jos useampi arvostelu" do
      kalja = FactoryBot.create(:beer)
      kalja2 = FactoryBot.create(:beer, style: "Porter")
      FactoryBot.create(:rating, beer: kalja, score: 15, user: user)
      FactoryBot.create(:rating, beer: kalja2, score: 20, user: user)
      FactoryBot.create(:rating, beer: kalja2, score: 45, user: user)

      expect(user.favorite_style).to eq(kalja2.style)
    end
  end

  describe "suosikkipanimo" do
    let(:user){ FactoryBot.create(:user) }

    it "metodi suosikkipanimon määrittämiseen" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "ilman arvosteluja ei ole suosikkipanimoa" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "on suosikkipanimo, jos useampi arvostelu" do
      kalja = FactoryBot.create(:beer)
      kalja2 = FactoryBot.create(:beer, style: "Porter")
      FactoryBot.create(:rating, beer: kalja, score: 15, user: user)
      FactoryBot.create(:rating, beer: kalja2, score: 20, user: user)
      FactoryBot.create(:rating, beer: kalja2, score: 45, user: user)

      expect(user.favorite_brewery).to eq(kalja2.brewery)
    end
  end
end
