class QuestionsController < ApplicationController
	$hello =""
	$i=0
	$score = 0
	$totalques=0
  $lead=0
  $k=0
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
      
      user_id = session[:user_id]
      $k = params[:subgenre]
      subgenre_id = params[:subgenre]
      le = Leaderboard.find_by(user_id:user_id,subgenre_id:subgenre_id)
      if(le)
        $lead =  le.score
      end
  		
      if($i == $totalques)
        qw = State.find_by(user_id:user_id,subgenre_id:subgenre_id)
        if(qw)
          qw.destroy
        end
      end
      print($i.to_s + "\n")
      if(params[:restore]=="1")
        q = State.find_by(user_id:user_id,subgenre_id:subgenre_id)
        if(q)
          $i = q.qno+1
        end
      end
  		print("show")
	 	  @questions = Question.where(subgenre_id:params[:subgenre])
    	@question = Question.where(subgenre_id:params[:subgenre])[$i]
  	end

  	def update
  		arr = ""
  		subgenre_id = params[:subgenre_id]
      print("\n")
      print(subgenre_id)
      print("\n")
      print("user id")
      user_id = session[:user_id]
      print(session[:user_id])
      print("\n")
  		
      genre_id = Subgenre.find(params[:subgenre_id]).genre_id
      x = Question.where(subgenre_id:subgenre_id)[$i]

      if(x.correctopt.length>1)
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
      else
        arr = params[:question][:country]
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
        if(x.correctopt.eql?(arr))
          flash[:success]="Correct Answer"
          $score +=10
        else
          flash[:danger]="Incorrect Answer"
        end
        qw = State.find_by(user_id:user_id,subgenre_id:subgenre_id)
        qr = Leaderboard.find_by(user_id:user_id,subgenre_id:subgenre_id)
        if(qw)
          qw.update_attributes(:score => $score, :qno => $i)
        else
          State.create(user_id:user_id,subgenre_id:subgenre_id,score:$score,qno:$i)
        end

        if(qr)
          if(qr.score < $score)
            qr.update_attributes(:score => $score)
          end
        else
            Leaderboard.create(user_id:user_id,subgenre_id:subgenre_id,score:$score)
        end
        

        $lead =  Leaderboard.find_by(user_id:user_id,subgenre_id:subgenre_id).score

	
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
	