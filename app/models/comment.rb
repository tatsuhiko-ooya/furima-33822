class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :message, presence: true
end
