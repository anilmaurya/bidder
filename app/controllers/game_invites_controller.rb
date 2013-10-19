class GameInvitesController < ApplicationController
  before_filter :authenticate_user!
  #Error code 1000 for some custom error, 1001 unexpected error contact admin
  def create
    if request.xhr?
      @game_invite = GameInvite.new(params[:game_invite], sender_user_id: current_user.id)
      if @game_invite.save
        Pusher['presence-invite_' + @game_invite.id].trigger('game_invite', {from: current_user.id})
        render :json => {valid: true}
      else
        render :json => {valid: false, error_code: '1000'}
      end
    end
  rescue Exception => e
    render :json => {valid: false, error_code: '1001'}
  end 
      
end
