module GameMovesHelper
  def current_player
    if @game.player_1.user == current_user
      return @game.player_1
    else
      return @game.player_2
    end
  end
end
