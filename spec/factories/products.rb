FactoryBot.define do
  factory :product do
    name { Faker::Food.vegetables }
    description { Faker::Food.description }
    category_id { rand(2..11) }
    condition_id { rand(2..7) }
    days_id { rand(2..4) }
    delivery_fee_id { rand(2..3) }
    prefecture_id { rand(2..48) }
    price { rand(300..9_999_999) }
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
