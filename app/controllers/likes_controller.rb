class LikesController < ApplicationController

    def create
        Like.create(user_id: current_user.id, comment_id: params[:id])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @like = Like.find_by(user_id: current_user.id, comment_id: params[:id])
        @like.destroy
        redirect_back(fallback_location: root_path)
    end

    def final_like
        Like.create(user_id: current_user.id, comment_id: params[:id])
        redirect_to "questions#show"
    end

end
