class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @question = @comment.question
        if @comment.save 
            current_user.balance -= @comment.question.response_cost
            current_user.save!
            @question.prize += @question.response_cost
            @question.save!
            redirect_to question_path(@question)
        else 
            flash.now[:errors] = @comment.errors.full_messages
            render "questions/show"
        end
    end
    
    def comment_params
        params.require(:comment).permit(:body, :question_id)
    end

    def destroy 
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_back(fallback_location: root_path)
    end

  
end
