class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :days
  belongs_to :prefecture
  belongs_to :user
  has_one_attached :image
  has_one :order
  has_many :likes
  has_many :like_users, through: :likes, source: :user

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :category_id
    with_options numericality: { other_than: 1 } do
      validates :condition_id
      validates :delivery_fee_id
      validates :days_id
      validates :prefecture_id
    end
    validates :price, numericality: { greater_than: 299, less_than: 10_000_000, only_integer: true }
  end
end
