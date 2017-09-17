class StaticPagesController < ApplicationController
  def home
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
