class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index] 
    before_action :check_auth, only: [:new, :create, :destroy]
    before_action :set_question, only: [:show, :destroy, :question_active?]
    before_action :set_questions, only: [:index, :new, :like]
    before_action :question_active?, only: [:show]
    before_action :deactivate_old_questions
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

    def decide_winner(question)
        winning_comment = question.comments.sort_by{|comment| comment.likes.count}.reverse.first
        most_likes = winning_comment.likes.count
        winning_comments = []

        all_comments_for_that_question = Comment.where(question_id: question.id)

        all_comments_for_that_question.each do |comment|
            if comment.likes.count == most_likes
                winning_comments.push(comment)
            end
        end

        if winning_comments.count == 1
            winning_user = winning_comments.user
            winning_user += winning_comment.question.prize
            winning_user.save
        else 
            redirect_to tie_breaker(winning_comments)
        end
    end
    
    def deactivate_old_questions
        @questions = Question.all
        @questions.each do |question|
            if question.active == true
                question.active = question.check_if_active?
                question.save 
                if question.active == false && question.comments.count != 0
                    decide_winner(question)
                elsif question.comments.count == 0
                    admin = user.where(email: "admin@a.com")
                    admin.balance += question.prize
                    admin.save
                end
            end
        end
    end
    
    def tie_breaker(winning_comments)
        @winning_comments = winning_comments
        # user is taken to the tie breaker page where they are asked who they want to give the money to. 

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
