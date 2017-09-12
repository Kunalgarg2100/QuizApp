class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

  end		
  def new
  	@user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
    	log_in @user
    	flash[:success] = "Welcome to the Quiz App!"
    	redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

#form_for helper method, which takes in an Active Record object and builds a form using the object’s attributes.
