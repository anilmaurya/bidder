class GameMovesController < ApplicationController

  def update
    @bid = Bid.new(params[:bid])
    @game = Game.find(@bid.game_id)
    @game_move = GameMove.find(params[:id])
    update_game_move
    if @player.update_amount(@bid.amount.to_i) && @player.valid?
      @player.revert_amount(@bid.amount.to_i)
      game_result
    else
      @result = 0
    end
  end

  def update_game_move
    if @game.player_1_id == @bid.player_id
      @game_move.update_attributes(player_1_bid: @bid.amount)
      @player = @game.player_1
    else
      @game_move.update_attributes(player_2_bid: @bid.amount)
      @player = @game.player_2
    end
  end

  def game_result
    @game_move.update_attributes(player_1_bid: @game.player_1.next_move(@game.player_2.current_amount, @game.level)) if @game.practise
    if @game_move.player_1_bid && @game_move.player_2_bid
      process_game
      @new_game_move = GameMove.create(game_id: @game.id)
      push_response unless @game.practise
    else
      render nothing: true
    end
  end

  def push_response
    Pusher['presence-gamemove'].trigger("move_#{another_player.user.id.to_s}", {win: @win, winner: (@win.name || @win.username).humanize, result: @result, current_amount: @player.current_amount, new_game_move_path: "/game_moves/#{@new_game_move.id}", player_1_amount: @player1.current_amount, player_2_amount: @player2.current_amount, current_player: @player})
  end

  def process_game
    @result = @game_move.calculate_result
    @game.update_level(@result)
    update_players
    find_winner
  end

  def find_winner
    if @game.level == 1 || @game.level == 7
      @win = @game.level == 1 ? @game.player_1 : @game.player_2
    else
      check_if_any_player_reaches_zero
    end
    assign_result_to_game
  end

  def update_players
    @game.reload
    @player1 = @game.player_1
    @player2 = @game.player_2
  end

  def check_if_any_player_reaches_zero
    if @player1.current_amount == 0 || @player2.current_amount == 0
      if @player1.current_amount == 0
        set_winner(@player2, '+')
      elsif @player2.current_amount == 0
        set_winner(@player1, '-')
      end
    end
  end

  def set_winner(player, opt)
    val =  @game.level.send(opt, player.current_amount)
    if val == 4
      @win = 'draw'
    elsif val > 4
      @win = @player2
    else
      @win = @player1
    end
  end

  def assign_result_to_game
    @game.update_attributes(result: @win.id) if (@win && @win != 'draw')
  end

  def another_player
    current_user == @game.player_1.user ? @game.player_2 : @game.player_1
  end
end
