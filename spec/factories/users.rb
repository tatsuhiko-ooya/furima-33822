FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password = 'a1' + Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    gimei = Gimei.name
    last_name {gimei.last.kanji}
    first_name {gimei.first.kanji}
    last_name_kana {gimei.last.katakana}
    first_name_kana {gimei.first.katakana}
    birth_day {Faker::Date.between(from: '1930-01-01', to: '2016-12-31')}
  end
end