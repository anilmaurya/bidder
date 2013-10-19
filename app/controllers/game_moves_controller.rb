class GameMovesController < ApplicationController

  def update
    bid = Bid.new(params[:bid])
    @game = Game.find(bid.game_id)
    @game_move = GameMove.find(params[:id])
    if @game.player_1_id == bid.player_id
      @game_move.update_attributes(player_1_bid: bid.amount)
      @player = @game.player_1
    else
      @game_move.update_attributes(player_2_bid: bid.amount)
      @player = @game.player_2
    end
    game_result
  end

  def game_result
    @game_move.update_attributes(player_1_bid: Player.next_move(@game.player_2.current_amount, @game.level)) if @game.practise
    if @game_move.player_1_bid && @game_move.player_2_bid
      @result = @game_move.calculate_result
      @game.reload
      @player1 = @game.player_1
      @player2 = @game.player_2
    else
      render nothing: true
    end
  end

end
