class GamesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @game_invite = GameInvite.new
  end

  def practise
    @player1   = Player.create(current_amount: INITIAL_AMOUNT, bot: true)
    @player2   = current_user.players.create(current_amount: INITIAL_AMOUNT)
    @game      = Game.create(practise: true, player_1_id: @player1.id, player_2_id: @player2.id, level: STARTING_LEVEL)
    @bid       = @player2.bids.build(game_id: @game.id)
    @game_move = GameMove.create(game_id: @game.id)
    render 'show'
  end

  def show
    @game    = Game.find(params[:id])
    @player1 = @game.player_1
    @player2 = @game.player_2
    @bid    = current_player.bids.build(game_id: @game.id)
    @game_move = GameMove.find_or_create_by(game_id: @game.id)
  end

  def current_player
    current_user == @player1 ? @player1 : @player2
  end

end
