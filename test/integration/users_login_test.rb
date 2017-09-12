require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
    @user = users(:michael)
  end


  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user #to check the right redirect target and
    follow_redirect! #to actually visit the target page
    assert_template 'users/show' 
    assert_select "a[href=?]", login_path, count: 0 #verifies that the login link disappears by verifying that there are zero login path links on the page #extra count: 0 option, we tell assert_select that we expect there to be zero links matching the given pattern. 
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end


  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end

'''

    Visit the login path.
    Verify that the new sessions form renders properly.
    Post to the sessions path with an invalid params hash.
    Verify that the new sessions form gets re-rendered and that a flash message appears.
    Visit another page (such as the Home page).
    Verify that the flash message doesn’t appear on the new page. 
'''