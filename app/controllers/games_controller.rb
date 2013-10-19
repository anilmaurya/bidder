class GamesController < ApplicationController

  def practise
    @player2  = current_user.players.build(initial_amount: INITIAL_AMOUNT)
    @game = Game.create(practise: true, player_2_id: current_user.id, level: STARTING_LEVEL)
    render 'show'
  end

end
