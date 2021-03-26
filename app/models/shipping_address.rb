class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :user

  with_options presence: true do
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/}
    validates :city
    validates :phone_number, format: {with:/\A\d{10,11}\z/}
    validates :block
    validates :user_id
  end
  validates :prefecture_id, numericality: {other_than: 1}
end
