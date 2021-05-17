class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        if @comment.save 
            redirect_to question_path(@comment.question_id)
        else 
            flash.now[:errors] = @comment.errors.full_messages
            @question = Question.find(params[:comment][:question_id])
            render "questions/show"
        end
    end

    def comment_params
        params.require(:comment).permit(:body, :question_id)
    end

    def destroy 
        @comment = Comment.find(params[:id])
        @comment.destroy
    end

end
