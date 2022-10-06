require 'rails_helper'

include Helpers

describe "Oluet" do
    let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }

    it "lisääminen onnistuu kelvoilla tiedoilla" do
        visit new_beer_path

        fill_in('beer[name]', with: 'Rainbow Lager')
        select('Lager', from: 'beer[style]')
        select('Koff', from: 'beer[brewery_id]')

        expect{
            click_button "Create Beer"
          }.to change{Beer.count}.from(0).to(1)
        expect(Beer.count).to eq(1)
    end

    it "lisääminen ei onnistuu epäkelvoilla tiedoilla" do
        visit new_beer_path

        fill_in('beer[name]', with: '')
        select('Lager', from: 'beer[style]')
        select('Koff', from: 'beer[brewery_id]')

        expect(Beer.count).to eq(0)
    end
end