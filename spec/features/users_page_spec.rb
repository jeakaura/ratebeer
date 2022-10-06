require 'rails_helper'

include Helpers

describe "Käyttäjä" do
  before :each do
    FactoryBot.create :user
  end

  describe "joka on luonut tunnukset" do
    it "pystyy kirjautumaan sisään oikeilla tunnuksilla" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "uudelleenohjautuu kirjautumissivulle väärillä tunnuksilla" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "oikeilla tiedoilla käyttäjä lisätään järjestelmään" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')
  
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end
