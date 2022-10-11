require 'rails_helper'

include Helpers

describe "Oluet" do
    let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
    let!(:style) { FactoryBot.create :style }
    let!(:user) { FactoryBot.create :user }

    it "lisääminen onnistuu kelvoilla tiedoilla" do
        sign_in(username: "Pekka", password: "Foobar1")
        visit new_beer_path

        fill_in('beer[name]', with: 'Rainbow Lager')
        select('test', from: 'beer[style_id]')
        select('Koff', from: 'beer[brewery_id]')

        expect{
            click_button "Create Beer"
          }.to change{Beer.count}.from(0).to(1)
        expect(Beer.count).to eq(1)
    end

    it "lisääminen ei onnistuu epäkelvoilla tiedoilla" do
        sign_in(username: "Pekka", password: "Foobar1")
        visit new_beer_path

        fill_in('beer[name]', with: '')
        select('test', from: 'beer[style_id]')
        select('Koff', from: 'beer[brewery_id]')

        expect(Beer.count).to eq(0)
    end
end