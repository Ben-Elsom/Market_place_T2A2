class ApplicationController < ActionController::Base

    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :forbidden
    
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    
    private
        def forbidden 
            flash[:alert] = "You are not authorized to perform that action."
            redirect_back(fallback_location: root_path)
        end

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password) }
        end
end
