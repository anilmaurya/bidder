class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_invitation_request
  before_filter :set_user_status

  def after_sign_in_path_for(resource)
    games_path
  end

  protected

  def set_user_status
    controller, action = params[:controller], params[:action]

    playing_game =  (controller == 'games' and action == 'show') or
    (controller == 'game_moves' and action == 'update')

    if current_user and current_user.is_playing != playing_game
      current_user.update_attribute(:is_playing, playing_game)
    end
  end

  def get_invitation_request
    if params[:action] == "create" and params[:controller] == 'devise/sessions'
      user = User.find_or_initialize_by(username: params[:user][:username])
      user.password = 'bidder'
      user.password_confirmation = 'bidder'
      user.save(validate: false)
      params[:user].merge!(:password => 'bidder')  
    end
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
