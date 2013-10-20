class GameInvitesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_game_invite, only: [:accept_invitation, :reject_invitation]
  #Error code 1000 for some custom error, 1001 unexpected error contact admin
  def create
    if request.xhr?
      game_invite_params = params[:game_invite] || {}
      @game_invite = GameInvite.new(game_invite_params.merge!(sender_user_id: current_user.id))
      if @game_invite.save
        Pusher['presence-game_invite'].trigger('invite_from_user', {from_id: current_user.id, from_username: current_user.username,
              to: @game_invite.receiver_user_id, game_invite: @game_invite.id})
        render :json => {valid: true, game_invite_id: @game_invite.id}
      else
        render :json => {valid: false, error_code: '1000', message: @game_invite.errors.full_messages.join(' | ')}
      end
    end
  rescue Exception => e
    render :json => {valid: false, error_code: '1001', message: e.message}
  end

  def accept_invitation
    if request.xhr?
      @game_invite.accept_status = true
      @game_invite.save!
      create_players
      game = Game.create(player_1_id: @player1.id, player_2_id: @player2.id, level: STARTING_LEVEL)

      Pusher['presence-game_invite'].trigger("accepted_#{@game_invite.sender_user_id}", {from_username: @game_invite.receiver_user.username, game_id: game.id})
      render :json => {game_id: game.id.to_s, valid: true}
    else
      flash[:error] = 'Invalid Request'
    end
  end

  def reject_invitation
    if request.xhr?
      @game_invite.accept_status = false
      @game_invite.save
      Pusher['presence-game_invite'].trigger("rejected_#{@game_invite.sender_user_id.to_s}", {from_username: @game_invite.receiver_user.username})
      render :json => {valid: true}
    else
      flash[:error] = 'Invalid Request'
    end
  end

  protected

  def create_players
    @player1 = Player.create(current_amount: INITIAL_AMOUNT, user_id: @game_invite.sender_user_id)
    @player2 = Player.create(current_amount: INITIAL_AMOUNT, user_id: @game_invite.receiver_user_id)
  end

  def get_game_invite
    @game_invite = GameInvite.find(params[:id])
  end
end
