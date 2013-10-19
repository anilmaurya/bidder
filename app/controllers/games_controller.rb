class GamesController < ApplicationController

  def practise
    @player  = current_user.players.build(initial_amount: INITIAL_AMOUNT)
    @game    = Game.create(practise: true, player_2_id: current_user.id, level: STARTING_LEVEL)
    @bid     = @player.bids.build(game_id: @game.id)
    render 'show'
  end

end
