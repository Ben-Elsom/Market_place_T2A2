class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end

    def create
        Comment.create(comment_params)
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

end
