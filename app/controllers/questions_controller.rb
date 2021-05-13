class QuestionsController < ApplicationController
    before_action :set_questions, only: [:index, :new]
    def index
        
    end

    def show 

    end

    def new

    end
    
    def create

    end

    def set_questions
        @questions = Question.all

    end

end
