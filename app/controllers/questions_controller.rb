class QuestionsController < ApplicationController
    before_action :set_questions, only: [:index, :new]
    before_action :set_question, only: [:show, :destroy]
    def index
        
    end

    def show      
        
        @comment = Comment.new
    end

    def new
        @question = Question.new
    end
    
    def create
        @question = Question.new(question_params)
        if @question.save
            redirect_to @question
        else
            flash.now[:errors] = @question.errors.full_messages
            render action: 'show'
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
        params.require(:question).permit(:title, :description, :prize, :response_cost, :closing_date_and_time )
    end
end
