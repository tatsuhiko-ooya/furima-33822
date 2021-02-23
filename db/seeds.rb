
user = User.create(
  nickname: "adminuser",
  email: "admin@example",
  password: "password123",
  password_confirmation: "password123",
  last_name: "管理者",
  first_name: "管理者",
  last_name_kana: "カンリシャ",
  first_name_kana: "カンリシャ",
  birth_day: "1989-03-09"
  )
  
9.times do
  gimei = Gimei.name
  user = User.new(
  nickname: Faker::Name.name,
  email: Faker::Internet.free_email,
  password: "password123",
  password_confirmation: "password123",
  last_name: gimei.last.kanji,
  first_name: gimei.first.kanji,
  last_name_kana: gimei.last.katakana,
  first_name_kana: gimei.first.katakana,
  birth_day: Faker::Date.between(from: '1930-01-01', to: '2016-12-31')
  )
user.save
end


10.times do
  Product.create(
  name: Faker::Food.vegetables,
  description: Faker::Food.description,
  category_id: rand(2..11),
  condition_id: rand(2..7),
  days_id: rand(2..4),
  delivery_fee_id: rand(2..3),
  prefecture_id: rand(2..48),
  price: rand(300..9_999_999),
  user_id: rand(1..10),
  image: ActiveStorage::Blob.create_and_upload!(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  )
end

