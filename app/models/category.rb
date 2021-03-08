class Category < ApplicationRecord
  has_many :products
  has_ancestry

  validates :name, presence: true


  def set_items
    if self.root?
      first_id = self.indirects.first.id
      last_id = self.indirects.last.id
      products = Product.where(category_id: first_id..last_id)
      return products
    elsif self.has_children?
      first_id = self.children.first.id
      last_id = self.children.last.id
      products = Product.where(category_id: first_id..last_id)
      return products
    else
      return self.products
    end
  end

end


