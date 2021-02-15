class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_day
    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: '平仮名、全角カタカナ、漢字のみ使用可能です。' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナのみ使用可能です。' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

   validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "英数字を混合させてください"}
end
