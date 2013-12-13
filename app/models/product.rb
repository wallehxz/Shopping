# encoding : UTF-8
class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  default_scope :order =>'title'
  has_many :line_items
  has_many :order , :through => :line_items
  before_destroy :ensure
  default_scope :order=>'title'
  validates_presence_of :title ,:message=>'标题不能为空'
  validates_presence_of :description ,:message=>'商品描述不能为空'
  validates_presence_of :image_url ,:message=>'图片不能为空'
  validates_numericality_of :price ,
                            :greater_than_or_equal_to=> 0.01,
                            :message=>'价格应该大于0.01元'
  validates_uniqueness_of :title
  validates_format_of :image_url,
                      :with=> %r{\.(gif|jpg|png)$}i,
                      :message=>'图片格式应该为gif,jpg,png'

  private
  def ensure
    if line_items.empty?
      return true
    else
      errors.add(:base,'在线物品未处理')
      return false
    end
  end
end
