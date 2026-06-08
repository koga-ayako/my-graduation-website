FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "カフェ#{n}" }
    sequence(:place_id) { |n| "place_id_#{n}" }
    address { "東京都渋谷区1-1-1" }
    postal_code { "150-0001" }
    phone { "03-1234-5678" }
    website { "https://example.com" }
    opening_hours { "10:00-20:00" }
    rating { 4.5 }
    latitude { 35.6812 }
    longitude { 139.7671 }
    cashless { true }
    density { 3 }
    photos { [] }
    
    trait :with_user do
      association :user
    end
    
    trait :with_photos do
      photos { ["photo_url_1.jpg", "photo_url_2.jpg"] }
    end
    
    trait :with_reviews do
      after(:create) do |shop|
        create_list(:review, 3, shop: shop)
      end
    end
  end
end