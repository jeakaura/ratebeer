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

    factory :style do
        text { "test" }
        desc { "test" }
    end

    factory :beer do
        name { "anonymous" }
        style
        brewery #olueen liittyvä panimo
    end

    factory :rating do
        score { 10 }
        beer #reittaukseen liittyvä olut
        user #reittaukseen liittyvä user
    end
end
