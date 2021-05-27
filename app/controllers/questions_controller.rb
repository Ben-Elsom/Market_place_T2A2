class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_question, only: [:show, :destroy, :question_active?, :tie_breaker, :edit, :update]
    before_action :check_auth, only: [:create, :destroy, :edit, :update]
    before_action :question_active?, only: [:show]
    before_action :deactivate_old_questions, only: [:index]
    before_action :decide_winner, only: [:index]
    def index
        # checking if any of the questions that the user has made needs a tie breaker and then redirectiing them to the tie breaker page for that question. 
        # If they do not need to go to thd tie breaker page then we are given a list of questions that are active. Then the most recent win is grabbed from the most recent win table.
        questions_that_need_tie_breaking = Question.where(user_id: current_user.id, active: false, prize_given: false).select{|question| question.needs_tie_breaker?}
        if !questions_that_need_tie_breaking.empty? 
            redirect_to tie_breaker_path(questions_that_need_tie_breaking[0].id)
        end
        @questions = Question.where(active: true)
        @most_recent_win = MostRecentWin.last
    end

    def closed_questions_index
        # getting all of the inactive question for the closed questions index and then sorting them by the most receently updated (aka most recently closed off)
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
        check_auth
        @current_user = current_user
    end
    
    def create
        # This method creates the new question. Checks that there is a prize specified, if there isn't then it will set it as 0 so that it will fail validation rather than throw and error
        # If the saving fails then it rerenders the 'new' page
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
        # This destroys a question and then takes them back to the home page
        @question.destroy
        redirect_to root_path
    end

    def edit
        # This method just sets the question in the before action and then sends them to the edit page
    end

    def update
        # This method updates a question with the allowed params and then sends them back to the root path. If it fails, it adds errors to the flash errors and re renders the edit page
        if @question.update(update_question_params)
            @question.update(update_question_params)
            redirect_to root_path
        else
            flash.now[:errors] = @question.errors.full_messages
            render action: 'edit'
        end
    end

    
    def tie_breaker
        # This is the method that makes the list of questions that need tie breaking. Then redircts the user to the tie breaker page. 
        most_likes = @question.comments.sort_by{|comment| comment.likes.count}.last.likes.count
        @questions_that_need_tie_breaking = []
        @question.comments.each do |comment|
            if comment.likes.count == most_likes 
                @questions_that_need_tie_breaking.push(comment)
            end
        end
    end

    def about

    end

    private
    def needs_tie_breaker?(question)
        # This is a method that checks where a specified comment neeeds a tie breaker by checking if the top two comments have the same number of likes 
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
        # This sets the allowed fields for making a question as well as saying that it must be in the hash question.
        params.require(:question).permit(:title, :description, :prize, :response_cost, :closing_date_and_time, :explaination_photo )
    end

    def update_question_params
        # This sets the allowed fields for updating a question as well as stating it must be inside the hash
        params.require(:question).permit(:title, :description, :closing_date_and_time, :explaination_photo )
    end

    def check_auth
        # This checks if a user that is trying to do an action has the authority in the question policy to do it. We run this as a before action on the sensitive actions. CHECK THIS ONE 
        begin 
            authorize @question
        rescue 
            authorize Question
        end
    end

    def question_active?
        # This is an action that checks whether an question is actually active as this allows the question to close while still inside the show action (because the deactiving is run on the index page)
        @active = @question.closing_date_and_time > DateTime.now
    end

    def deactivate_old_questions
        # This is an action that checks all active questions and sees if they need to be changed to not active
        @questions = Question.where(active: true)
        @questions.each do |question|
            question.active = question.is_active?
            question.save 
        end 
    end 

    def decide_winner
        # This is the action that decides the winner of a question. If there are no comments on a page then the money goes to the admin, if there are comments and they don't need a tie breaker. Then sort by most likes and pick the most liked question 
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