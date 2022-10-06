FactoryBot.define do
    factory :user do
        username { "Pekka" }
        password { "Foobar1" }
        password_confirmation { "Foobar1" }
    end

    factory :brewery do
        name { "anonymous" }
        year { 1900 }
    end

    factory :beer do
        name { "anonymous" }
        style { "Lager" }
        brewery #olueen liittyvä panimo
    end

    factory :rating do
        score { 10 }
        beer #reittaukseen liittyvä olut
        user #reittaukseen liittyvä user
    end
end
