class User < ApplicationRecord
  #dependent: :destroy
	attr_accessor :remember_token

#	  validates :name, presence: true
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#he way to do this is with a callback, which is a method that gets invoked at a particular point in the lifecycle of an Active Record object. 
#In the present case, that point is before the object is saved, so we’ll use a before_save callback to
#downcase the email attribute before saving the user
	#before_save { self.email = self.email.downcase }
	before_save { email.downcase! }

	# inside the User model the self keyword is optional on the right-hand side:

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:name, presence: true, length: { maximum: 49 })
	validates(:email, presence: true,length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false })
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 },allow_nil: true
	# Returns the hash digest of the given string.
  	def self.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	def self.new_token
    	SecureRandom.urlsafe_base64
  	end
  	
  	def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?(remember_token) #o verify that a given remember token matches the user’s remember digest, 
    	return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

  	# Forgets a user.
  	def forget
    	update_attribute(:remember_digest, nil)
  	end

    def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
