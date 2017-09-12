class User < ApplicationRecord
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
	validates :password, presence: true, length: { minimum: 6 }
	# Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
end
