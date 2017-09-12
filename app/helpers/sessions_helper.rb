module SessionsHelper
	def log_in(user)
    	session[:user_id] = user.id
  	end
  	'''
  	In contrast to the persistent cookie created by the cookies method (Section 9.1), the temporary cookie created by the session method expires immediately when the browser is closed
  	'''
  	def current_user
  		@current_user ||= User.find_by(id: session[:user_id])
	end
#instance variable
	def logged_in?
    	!current_user.nil?
  	end

  	def log_out
    	session.delete(:user_id)
    	@current_user = nil
  	end

end
