class LikesController < ApplicationController

    def create
        # This creates a like with the two required pieces of information, user_id and Comment_id 
        Like.create(user_id: current_user.id, comment_id: params[:id])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        # This find the like that the user has hit the destroy like (aka unlike) button on. Destroys that like and then redirects them to where they were 
        @like = Like.find_by(user_id: current_user.id, comment_id: params[:id])
        @like.destroy
        redirect_back(fallback_location: root_path)
    end

    def final_like
        # This is very similar to the create like method execpt that it sends them back to the root path because if we sent someone back from the tie breaker page after they liked a comment they would stay on the tie breaker page which would be confusing for the user
        like = Like.create(user_id: current_user.id, comment_id: params[:id])
        redirect_to root_path
    end

end
