class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index] 
    before_action :check_auth, only: [:new, :create, :destroy]
    before_action :set_question, only: [:show, :destroy, :question_active?]
    before_action :set_questions, only: [:index, :new, :like]
    before_action :question_active?, only: [:show]
    before_action :deactivate_old_questions_and_decide_winner, except: [:deactivate_old_questions_and_decide_winner]
    def index
        @questions = Question.where(active: "true")

        # @questions = @questions.order(:response_cost)
        # if radio button says highest prize
        # @questions = @questions.order(:prize).reverse

        #if radio button says lowest response cost


        # if radio button is least liked top comment
        # comments = @question.comment.order(:likes)
        # top_comment = comments.first
        # @questions = @question


    end

    def show     
        @comment = Comment.new
    end 

    def new
        @question = Question.new
        @current_user = current_user
    end
    
    def create
        @question = Question.new(question_params)
        @question.prize = @question.prize.round(2)
        @question.response_cost = @question.response_cost.round(2)
        @question.user_id = current_user.id
        if @question.save
            current_user.balance -= question_params[:prize].to_i
            current_user.save
            redirect_to @question
        else
            render action: 'new'
        end
    end
    
    
    def destroy
        @question.destroy
        redirect_to root_path
    end
    
    def update
        
    end

    def question_active?
        @active = @question.closing_date_and_time > DateTime.now
    end
    
    def deactivate_old_questions_and_decide_winner
        @most_recent_win = "test"
        @questions = Question.all
        @questions.each do |question|
            if question.active == true
                question.active = question.check_if_active?
                question.save
                if question.active == false && question.comments.count != 0
                    winning_comment = question.comments.sort_by{|comment| comment.likes.count}.reverse.first
                    winning_user = User.find(winning_comment.user_id)
                    winning_user.balance += winning_comment.question.prize
                    winning_user.save
                    
                end
            end
        end
    end
    
    private
    def set_questions
        @questions = Question.all
    end
    
    def set_question 
        
        @question = Question.find(params[:id])
    end

    def question_params
        params.require(:question).permit(:title, :description, :prize, :response_cost, :closing_date_and_time, :explaination_photo )
    end

    def check_auth
        authorize Question
    end

end
