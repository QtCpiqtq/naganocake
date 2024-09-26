class Order < ApplicationRecord
  attr_accessor :select_address, :address_id
  
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  before_validation :update_params
  after_create :create_details
  
  enum payment_method: { "クレジットカード": 0, "銀行振込": 1 }
  enum status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }

  private
  
  def update_params
    case self.select_address.to_i
    when 0
      self.postal_code = self.customer.postal_code
      self.address = self.customer.address
      self.name = self.customer.name
    when 1
      address = Address.find(self.address_id)
      self.postal_code = address.postal_code
      self.address = address.address
      self.name = address.name
    end
    self
  end
  
  def create_details
    cart_items = self.customer.cart_items
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = self.id
      order_detail.item_id = cart_item.item_id
      order_detail.amount  = cart_item.amount
      order_detail.price_inc_tax = cart_item.item.with_tax_price
      order_detail.save!
    end
    cart_items.destroy_all
  end
end
