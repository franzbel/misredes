class User < ActiveRecord::Base
  attr_accessor :remember_token
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

  # Retorna el hash digest de la cadena dada.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # Retorna un token aleatorio.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Retorna true si el token dado empareja con el digest(la version hasheada del token)
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end

