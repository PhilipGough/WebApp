class User < ActiveRecord::Base

   has_many :addresses, dependent: :destroy
   has_many :orders

   before_save { email.downcase! }
   validates :name,  presence: true, length: { maximum: 50 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
   validates :email, presence: true, length: { maximum: 255 },
   format: { with: VALID_EMAIL_REGEX },
   uniqueness: { case_sensitive: false }
   has_secure_password
   validates :password, length: { minimum: 6 }, allow_blank: true 


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
end  


def cart_count
    $redis.scard "cart#{id}"
end 


def current_user_cart
    "cart#{current_user.id}"
end  

end
