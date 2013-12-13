# encoding : UTF-8
require 'digest/sha2'
class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :username, :birthday
  validates_uniqueness_of    :name , :message =>'登录名已经存在，请修改！'
  validates_presence_of       :name ,:message =>'登录名不能为空！'
  validates_presence_of       :username ,:message =>'用户名不能为空！'
  validates_presence_of       :birthday ,:message =>'出生日期不能为空！'
  validates  :password ,:confirmation=>true
  attr_accessor :password_confirmation
  attr_reader  :password
  validate :password_must_be_prensent

  def User.authenticate(name,password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password)
        user
      end
    end
  end
  def User.encrypt_password(password)
    Digest::SHA2.hexdigest(password)
  end

  def password=(password)
    @password = password
    if password.present?
      self.hashed_password = self.class.encrypt_password(password)
    end
  end

  private
  def password_must_be_prensent
    errors.add(:password ,'错误的密码！') unless hashed_password.present?
  end
  def genetate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end