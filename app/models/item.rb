class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_datail, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  validates :genre_id, presence: true
  validates :image, presence: true
  
  def with_tax_price
    (price * 1.1).floor
  end
  
  enum is_active: { "販売中": true, "販売停止中": false }
end
