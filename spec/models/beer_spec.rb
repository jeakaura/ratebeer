require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "oluen" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_style) { Style.new text: "test", desc: "test" }
    let(:test_good_beer) { Beer.create name: "testbeer", style: test_style, brewery: test_brewery }
    let(:test_noname_beer) { Beer.create name: "", style: test_style, brewery: test_brewery }
    let(:test_missingstyle_beer) { Beer.create name: "testbeer", brewery: test_brewery }

    it "luonti onnistuu jos nimi, tyyli, panimo asetettu" do
      expect(test_good_beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
    end

    it "luonti ei onnistu jos ei nimeä" do
      expect(test_noname_beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end

    it "luonti ei onnistu jos ei tyyliä" do
      expect(test_missingstyle_beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end
  end
end
