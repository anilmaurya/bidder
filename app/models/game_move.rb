class GameMove
  include Mongoid::Document
  field :player_1_bid, type: Integer
  field :player_2_bid, type: Integer
  belongs_to :game

  def calculate_result
    return 1 if self.player_1_bid > self.player_2_bid
    return 2 if self.player_2_bid > self.player_2_bid
    return self.game.draw_winner && self.game.change_draw_winner
  end
end
