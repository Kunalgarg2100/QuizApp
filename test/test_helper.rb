require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

#is_logged_in? instead of logged_in? so that the test helper and Sessions helper methods have different names, which prevents them from being mistaken for each other
  # Add more helper methods to be used by all tests here...
end
