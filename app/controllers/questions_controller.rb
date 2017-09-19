class QuestionsController < ApplicationController
	before_action :logged_in_user, only: [:show]
	skip_before_action :verify_authenticity_token
	$hello =""
	$i=0
	$score = 0
	$totalques=0
	$lead=0
	$k=0
	$fif=0
	$dlf=0
  	$outp=[]
	$subgenre_id=0
	def new
		@question = Question.new
		$hello = params[:subgenre]
		print($hello)
		print($hello)
		print($hello)
		print($hello)
		print($hello)

	end

	def create
		print(params[:subgenre_id])
		print(params[:subgenre_id])
		print(params[:subgenre_id])
		print(params[:subgenre_id])
		print(params[:subgenre_id])
		
		print(params[:subgenre_id])
		$hello = Subgenre.find(params[:subgenre_id].to_i)
		@question = $hello.questions.build(question_parms)
		if @question.save
			flash[:success] = "Question Added"
			redirect_to ($hello)
		else
			print(@question.errors.full_messages)
			flash[:danger] = "Question  Not Added"
			render 'new'
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

	def lifeline
		$fif=1
	end

	def doublife
		$dlf=1
	end




	def show

		$totalques = Question.where(subgenre_id:params[:subgenre]).count

		user_id = session[:user_id]
		$k = params[:subgenre]
		$subgenre_id = params[:subgenre]
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
				$score=q.score
			end
		end
		print("show")
		@questions = Question.where(subgenre_id:params[:subgenre])
		@question = Question.where(subgenre_id:params[:subgenre])[$i]
		if(@question)
		ans = @question.correctopt
		$outp = []
		if(ans.eql?("A"))
			xd = ([*1..4] - [1]).sample
			mn = ([*1..4] - [1,xd]).sample
		elsif(ans.eql?("B"))
			xd = ([*1..4] - [2]).sample
			mn = ([*1..4] - [2,xd]).sample
		elsif(ans.eql?("C"))
			xd = ([*1..4] - [3]).sample
			mn = ([*1..4] - [3,xd]).sample
		else
			xd = ([*1..4] - [4]).sample
			mn = ([*1..4] - [4,xd]).sample
		end
		$outp.push("c" + xd.to_s)
		$outp.push("c" + mn.to_s)
		print($outp)
	end
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
    flg=0
		if arr.to_s.empty?
			flash[:danger]="Please select an option"
      flg=1
    end
		if x.correctopt.length == 1 and $dlf != 1
			if arr.length > 1  
				flash[:danger]="Please select only one option"
        flg=1
			end
    end

    if $dlf == 1
      if arr.length == 1
        flash[:danger]="Please select two options"
        flg=1
      end
    end
    if(flg == 1)
      redirect_back(fallback_location: 'show')
    else



      print($dlf)
      print("\n\n\n\n")
			if $dlf != 1
				if(x.correctopt.eql?(arr))
					flash[:success]="Correct Answer"
          print("corect")
					$score +=10
				else
					flash[:danger]="Incorrect Answer"
          print("incorere")

				end
			else
				if(x.correctopt.eql?(arr[0]))
					flash[:success]="Correct Answer"
					$score +=10
				elsif x.correctopt.eql?(arr[1])
					flash[:success]="Correct Answer"
					$score +=10
				else
					flash[:danger]="Incorrect Answer"
				end
				$dlf = 2

			end
      print("hello")
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

