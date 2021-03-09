require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  # has_secure_token
  before_create :set_access_token

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  private 

  def set_access_token
    self.auth_token = generate_token
  end

  def generate_token
    loop do 
      token = SecureRandom.hex(20)
      break token unless User.where(auth_token: token).exists?
    end
  end
  
end
