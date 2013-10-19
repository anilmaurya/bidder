class GameMovesController < ApplicationController

  def update
    bid = Bid.new(params[:bid])
    game = Game.find(bid.game_id)
    game_move = GameMove.find(params[:id])
    if game.player_1_id == bid.player_id
      game_move.update_attributes(player_1_bid: bid.amount)
    else
      game_move.update_attributes(player_2_bid: bid.amount)
    end
    game_result(game, game_move)
  end

  def game_result(game, game_move)
    game_move.update_attributes(player_1_bid: Player.next_move) if game.practise

    if game_move.player_1_bid && game_move.player_2_bid
      @result = game_move.calculate_result
    else
      render nothing: true
    end
  end

end
