#encoding : utf-8
class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type, :phone
  PAYMENT_TYPES = ['货到付款', '网银支付','淘宝支付']
  has_many :line_items, :dependent => :destroy
  validates_presence_of :name,     :message =>'用户名不能为空'
  validates_presence_of :email,     :message =>'邮箱不能为空'
  validates_presence_of :address, :message =>'送货地址不能为空'
  validates_presence_of :phone,    :message =>'联系方式不能为空'
  validates :pay_type ,:inclusion => PAYMENT_TYPES
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
