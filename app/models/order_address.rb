class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :building, :phone_number, :block, :user_id, :product_id

  with_options presence: true do
    validates :post_code
    validates :city
    validates :phone_number
    validates :block
    validates :user_id
    validates :product_id
  end
  validates :prefecture_id, numericality: {other_than: 1}

  def save
    order = Order.create(user_id: user_id, product_id: product_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, building: building, phone_number: phone_number, block: block, order_id: order.id)
  end

end


