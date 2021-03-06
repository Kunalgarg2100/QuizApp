class GenresController < ApplicationController

	 def index
      $i=0
      $score=0
      $fif=0
      $dlf=0

    #@user = User.find(params[:id])
    	@genres = Genre.all

    end
	def new
		@genre = Genre.new
	end

	def create
    	@genre = Genre.new(genre_params)
      print("\n")
      print(params[:genre][:content])
    	if(@genre.save)
    		redirect_to genre_url(@genre)
  		  #	flash[:success] = "Genre Added"
    	else
     		render 'new'
    	end
  	end
	def show
  	@genre = Genre.find(params[:id])
  	@subgenres = @genre.subgenres.all

	end
	def edit
  	@genre = Genre.find(params[:id])
  	end

	def update
  	@genre = Genre.find(params[:id])
    if @genre.update_attributes(genre_params)
    		flash[:success] = "Genre updated"
    	  redirect_to genres_path
  	else
    	 render 'edit'
  	end
	end

	def destroy
  	Genre.find(params[:id]).destroy
  	flash[:success] = "Genre deleted"
  	redirect_to '/genres'
	end

	private
  	def genre_params
    		params.require(:genre).permit(:content, subgenres_attributes: [:cont])
  	end


end
