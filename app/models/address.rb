class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :order

  with_options presence: true do
    validates :post_code
    validates :prefecture_id, numericality: {other_than: 1}
    validates :city
    validates :phone_number
    validates :block
  end
end


