class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_auth, only: [:new, :create, :destroy]
    before_action :set_question, only: [:show, :destroy, :question_active?, :tie_breaker]
    before_action :set_questions, only: [:index, :new, :like]
    before_action :question_active?, only: [:show]
    before_action :deactivate_old_questions, only: [:index]
    before_action :decide_winner, only: [:index]
    def index
        questions = Question.where(user_id: current_user.id)
        questions = questions.select{|question| question.needs_tie_breaker?}
        if questions.empty? == false
            redirect_to tie_breaker_path(questions[0].id)
        end

        @questions = Question.where(active: "true")
        @most_recent_win = MostRecentWin.last
    end

    def closed_questions_index
        @questions = Question.where(active: "false")
        @questions = @questions.sort_by{|question| question.updated_at}
    end

    def show
        @comment = Comment.new
        @comments = @question.comments.sort_by{|comment| comment.likes.count}.reverse
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

    
    def tie_breaker
        most_likes = @question.comments.sort_by{|comment| comment.likes.count}.last.likes.count
        @questions_that_need_tie_breaking = []
        @question.comments.each do |comment|
            if comment.likes.count == most_likes 
                @questions_that_need_tie_breaking.push(comment)
            end
        end
    end

    private
    def needs_tie_breaker?(question)
        sorted_by_likes = question.comments.sort_by{|comment| comment.likes.count}
        if sorted_by_likes.last.likes.count == sorted_by_likes[-2].likes.count
            return true
        else
            return false
        end
    end

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

    def question_active?
        @active = @question.closing_date_and_time > DateTime.now
    end

    def deactivate_old_questions
        @questions = Question.where(active: true)
        @questions.each do |question|
            question.active = question.is_active?
            question.save 
        end 
    end 

    def decide_winner
        questions = Question.where(active: false, prize_given: false)
        if questions 
            questions.each do |question|
                if question.comments.count == 0
                    admin = User.find_by(email: "admin@a.com")
                    admin.balance += question.prize
                    admin.save
                    question.prize_given = true
                    question.save
                elsif question.comments.count == 1 or !needs_tie_breaker?(question)
                    winning_comment = question.comments.sort_by{|comment| comment.likes.count}.last
                    winning_user = winning_comment.user
                    winning_user.balance += winning_comment.question.prize
                    winning_user.save
                    question.prize_given = true
                    question.save
                    MostRecentWin.create(question: question, comment: winning_comment)
                end
            end
        end
    end
end 