class QuestionsController < ApplicationController
    before_action :set_questions, only: [:index, :new]
    before_action :set_question, only: [:show, :destroy]
    def index
        
    end

    def show 

    end

    def new
        @question = Question.new
    end
    
    def create
        @question = Question.create(question_params)
        redirect_to @question
    end

    def set_questions
        @questions = Question.all
    end

    def set_question 
        @question = Question.find(params[:id])
    end

    def destroy
        @question.destroy
        redirect_to root_path
    end

    def question_params
        params.require(:question).permit(:title, :description, :prize, :response_cost )
    end
end
