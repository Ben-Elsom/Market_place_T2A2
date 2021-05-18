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

    def like 
        Like.create(user_id: current_user.id, post_id: @post.id)
        redirect_to questions_path(@post)
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
