class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_invitation_request
  
  def after_sign_in_path_for(resource)
    games_path
  end
  
  protected
    def get_invitation_request
      if current_user
        @invitation_request = GameInvite.where(receiver_user_id: current_user.id, accept_status: nil).first  
      else
        if params[:user]
          @user = User.new(params[:user])     
        else
          @user = User.new 
        end
      end
    end
end
