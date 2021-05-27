class CommentsController < ApplicationController
    before_action :check_auth, only: [:destroy]
    def create
        # This method creates the comment. If successful it will take the response cost from the user and add it to the question pool. 
        # # If it fails it will give the user an error and take them back to the question show page they were on.
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @question = @comment.question
        if @comment.save
            current_user.balance -= @comment.question.response_cost
            current_user.save
            @question.prize += @question.response_cost
            @question.save
            redirect_to question_path(@question)
        else 
            flash.alert = @comment.errors.full_messages
            redirect_to question_path(@question)
        end
    end
    
    def comment_params
        # This are the parameters that are allowed to be add to a comment as well as stating that it must be inside a hash called comment
        params.require(:comment).permit(:body, :question_id)
    end

    def destroy 
        # This finds the comment that the user is hiting the delete button on and then destroy that comment
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_back(fallback_location: root_path)
    end

    def check_auth
        # This checks whether the action that a user is trying to perform is allowed in the comment policy
        authorize Comment
    end
end
