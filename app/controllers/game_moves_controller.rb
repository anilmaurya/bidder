class GameMovesController < ApplicationController

  def update
    bid = Bid.new(params[:bid])
    @game = Game.find(bid.game_id)
    @game_move = GameMove.find(params[:id])
    update_game_move(bid)
    game_result
  end

  def update_game_move(bid)
    if @game.player_1_id == bid.player_id
      @game_move.update_attributes(player_1_bid: bid.amount)
      @player = @game.player_1
    else
      @game_move.update_attributes(player_2_bid: bid.amount)
      @player = @game.player_2
    end
  end

  def game_result
    @game_move.update_attributes(player_1_bid: @game.player_1.next_move(@game.player_2.current_amount, @game.level)) if @game.practise
    if @game_move.player_1_bid && @game_move.player_2_bid
      process_game
      p "move_#{another_player.id}"
      Pusher['presence-gamemove'].trigger("move_#{another_player.user.id.to_s}", {win: @win, result: @result, current_amount: @player.current_amount})
    else
      render nothing: true
    end
  end

  def process_game
    @result = @game_move.calculate_result
    @game.update_level(@result)
    find_winner
  end

  def find_winner
    if @game.level == 1 || @game.level == 7
      @win = @game.level == 1 ? @game.player_1 : @game.player_2
    else
      load_players
      check_if_both_player_reaches_zero
    end
  end

  def load_players
    @game.reload
    @player1 = @game.player_1
    @player2 = @game.player_2
  end

  def check_if_both_player_reaches_zero
    if @player1.current_amount == 0 && @player2.current_amount == 0
      if @game.level == 4
        @win = 'draw'
      elsif @game.level > 4
        @win = @player2
      else
        @win = @player1
      end
    end
  end

  def another_player
    current_user == @game.player_1.user ? @game.player_2 : @game.player_1
  end
end
