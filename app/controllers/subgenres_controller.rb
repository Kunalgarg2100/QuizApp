class SubgenresController < ApplicationController
	$hello =""
	def destroy
		y = Subgenre.find(params[:id]).genre_id
    	Subgenre.find(params[:id]).destroy
    	flash[:success] = "Subgenre deleted"
    	redirect_to genre_url(y)
    end

    def new
    	@subgenre = Subgenre.new
    	$hello = Genre.find(params[:genre])
    end 
  
    def create
    	@subgenre = $hello.subgenres.build(subgenre_parms)
    	if @subgenre.save
  		  	flash[:success] = "Subgenre Added"
    		redirect_to ($hello)
    	else
    		print(@subgenre.errors.full_messages)
  		  	flash[:danger] = "Subgenre Not Added"
    		#redirect_to root_url

    	end
    end

    def edit
    	@subgenre = Subgenre.find(params[:id])
	end
	def show
    	@subgenre = Subgenre.find(params[:id])
    	#@subgenres = @genre.subgenres.all

  	end

	private
		def subgenre_parms
      		params.require(:subgenre).permit(:cont)
      	end
end
