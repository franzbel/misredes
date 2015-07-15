class User < ActiveRecord::Base
  before_save { self.email= self.email.downcase }

  validates :name , presence:   true
  validates :email, presence:   true
  validates :name , length:     { maximum: 50 }
  validates :email, length:     { maximum: 255 }
  validates :email, format:     { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: {minimum: 6}
  validates :password, presence: true
end
