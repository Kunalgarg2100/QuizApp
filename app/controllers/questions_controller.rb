class QuestionsController < ApplicationController
	$hello =""
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
    	@question = Question.find(params[:id])
  	end

  	private
		def question_parms
      		params.require(:question).permit(:ques,:optA, :optB, :optC ,:optD, :correctopt)
      	end
end
	