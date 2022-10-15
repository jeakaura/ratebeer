b1 = Brewery.create name: "Koff", year: 1897, active: true
b2 = Brewery.create name: "Malmgard", year: 2001, active: true
b3 = Brewery.create name: "Weihenstephaner", year: 1040, active: true

s1 = Style.create text: "Lager", desc: "Lager"
s2 = Style.create text: "Pale Ale", desc: "Pale Ale"
s3 = Style.create text: "Weizen", desc: "Weizen"

b1.beers.create name: "Iso 3", style_id: s1
b1.beers.create name: "Karhu", style_id: s1
b1.beers.create name: "Tuplahumala", style_id: s1
b2.beers.create name: "Huvila Pale Ale", style_id: s2
b2.beers.create name: "X Porter", style_id: s3
b3.beers.create name: "Hefeweizen", style_id: s3
b3.beers.create name: "Helles", style_id: s1
