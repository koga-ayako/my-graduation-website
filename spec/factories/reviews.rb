FactoryBot.define do
  factory :review do
    association :user
    association :shop
    
    sequence(:content) { |n| "これは#{n}番目のレビューです。とても良いお店でした。" }
    rating { 4 }
    
    trait :with_image do
      review_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg') }
    end
    
    trait :high_rating do
      rating { 5 }
      content { "素晴らしいお店でした！また来たいです。" }
    end
    
    trait :low_rating do
      rating { 1 }
      content { "あまり良くありませんでした。" }
    end
    
    trait :long_content do
      content { "とても素晴らしいお店でした。" * 20 }
    end
  end
end