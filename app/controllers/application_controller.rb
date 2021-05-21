class ApplicationController < ActionController::Base

    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :forbidden


    private
    def forbidden 
        flash[:alert] = "You are not authorized to perform that action."
        redirect_back(fallback_location: root_path)
    end

end
