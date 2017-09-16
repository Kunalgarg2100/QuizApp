class QuestionsController < ApplicationController
	$hello =""
	$i=0
	$score = 0
	$totalques=0
	def new
		@question = Question.new
    	$hello = Subgenre.find(params[:subgenre])
	end

	def create
		@question = $hello.questions.build(question_parms)
    	if @question.save
  		  	flash[:success] = "Question Added"
    		redirect_to ($hello)
    	else
    		print(@question.errors.full_messages)
  		  	flash[:danger] = "Question  Not Added"
    		#redirect_to root_url
    	end
    end

    def destroy
		y = Question.find(params[:id]).subgenre_id
    	Question.find(params[:id]).destroy
    	flash[:success] = "Question deleted"
    	redirect_to subgenre_url(y)
    end

    def edit
    	@question = Question.find(params[:id])
	end

	def show
		$totalques = Question.where(subgenre_id:params[:subgenre]).count
  		print($i.to_s + "\n")

  		if($totalques==$i)
  			$i=0
  			print($score.to_s + "\n")
  			redirect_to root_url
  		end
		print("show")
		@questions = Question.where(subgenre_id:params[:subgenre])
    	@question = Question.where(subgenre_id:params[:subgenre])[$i]
  	end

  	def update
  		arr = ""
  		subgenre_id = params[:subgenre_id]
  		genre_id = Subgenre.find(params[:subgenre_id]).genre_id

  		if(params[:question][:optA].eql?("1"))
  			arr = arr + "A"
  		end

  		if(params[:question][:optB].eql?("1"))
  			arr = arr + "B"
  		end

  		if(params[:question][:optC].eql?("1"))
  			arr = arr + "C"
  		end
  		if(params[:question][:optD].eql?("1"))
  			arr = arr + "D"
  		end
  		print("answer =\n")
  		print(arr)
  		if arr.empty?
  			flash[:danger]="please select an option"
  		#	@questions = Question.where(subgenre_id:params[:subgenre])
  			#render 'quiz'
  			#redirect_to '/quiz?genre=' + genre_id.to_s + "&subgenre=" +  subgenre_id.to_s
  			redirect_back(fallback_location: 'show')
  		else
  			print(subgenre_id.to_s + "\n")
  			x = Question.where(subgenre_id:subgenre_id)[$i]
  			print(x.correctopt)
  			
  			#x = x.correctopt
  			if( x.correctopt.eql?(arr))
  				$score +=10
  			end	
  			print($i.to_s + "\n")
  			$i+=1
  			print($i.to_s + "\n")
  			print($totalques.to_s + "\n")
  			redirect_back(fallback_location: 'show')
  		end
  	end
  	private
		def question_parms
      		params.require(:question).permit(:ques,:optA, :optB, :optC ,:optD, :correctopt)
      	end
end
	