class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_auth, only: [:new, :create, :destroy]
    before_action :set_question, only: [:show, :destroy, :question_active?, :tie_breaker, :edit, :update]
    before_action :question_active?, only: [:show]
    before_action :deactivate_old_questions, only: [:index]
    before_action :decide_winner, only: [:index]
    def index
        # checking if any of the questions that the user has made needs a tie breaker and then redirectiing them to the tie breaker page for that question.
        questions_that_need_tie_breaking = Question.where(user_id: current_user.id, active: false, prize_given: false).select{|question| question.needs_tie_breaker?}
        if !questions_that_need_tie_breaking.empty? 
            redirect_to tie_breaker_path(questions_that_need_tie_breaking[0].id)
        end
        # retrieving all of the active questions to display on the index page 
        @questions = Question.where(active: true)
        # Getting the most recent win to show up on the index page
        @most_recent_win = MostRecentWin.last
    end

    def closed_questions_index
        # getting all of the inactive question for the closed questions index
        @questions = Question.where(active: false).sort_by{|question| question.updated_at}
    end

    def show
        # Opening a new instance of a comment so my form knows what element the form is for
        @comment = Comment.new
        @comments = @question.comments.sort_by{|comment| comment.likes.count}.reverse
    end 

    def new
        # Opening a new instance of a comment so my form knows what element the form is for
        @question = Question.new
        @current_user = current_user
    end
    
    def create
        # I am calling question.new so that my question form knows what to base the form off 
        @question = Question.new(question_params)
        if !@question.prize.nil?
            @question.prize = @question.prize.round(2) 
        else 
            @question.prize = 0
        end
        if !@question.response_cost.nil?
            @question.response_cost = @question.response_cost.round(2) 
        else 
            @question.response_cost = 0
        end
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

    def edit

    end

    def update
        if @question.update(update_question_params)
            @question.update(update_question_params)
            redirect_to root_path
        else
            flash.now[:errors] = @question.errors.full_messages
            render action: 'edit'
        end
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
    
    def set_question 
        # This is to set the question passed on what page the user is on. 
        @question = Question.find(params[:id])
    end

    def question_params
        params.require(:question).permit(:title, :description, :prize, :response_cost, :closing_date_and_time, :explaination_photo )
    end

    def update_question_params
        params.require(:question).permit(:title, :description, :closing_date_and_time, :explaination_photo )
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