class QuestionsController < ApplicationController
    before_action :set_questions, only: [:index, :new, :like]
    before_action :set_question, only: [:show, :destroy]
    def index
        @questions.each do |question|
            question.check_if_active?
        end
        @questions = Question.where(active: "true")
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
end
