class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtentions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :days
  belongs_to :prefecture
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :description
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :days_id
    validates :prefecture_id
  end
  validates :price, format: { with: /^[０-９]+$/, message: 'は半角で入力してください' },
  inclution: { in: 300..9999999 } #半角数字のみ300~9999999にすること
end
