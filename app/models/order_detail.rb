class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  def get_item(id)
    Item.find(id)
  end
end
