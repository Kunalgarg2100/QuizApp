class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		user =   current_user
  		redirect_to user
  	end
  end

  def help
  end

  def about
  end

  def contact
  end

  def index
    @genres = Genre.all
  end

  def show
    $k = params[:subgenre]
  end
end
