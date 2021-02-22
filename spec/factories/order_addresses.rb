FactoryBot.define do
  factory :order_address do
    post_code {"123-4567"}
    prefecture_id {rand(2..48)}
    city  {Gimei.address.town.kanji}
    building {"テストタワー"}
    phone_number {Faker::Number.number(digits: 10)}
    block {Faker::Number.number(digits: 4)}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
