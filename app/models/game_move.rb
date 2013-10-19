class GameMove
  include Mongoid::Document
  include Mongoid::Timestamps

  field :player_1_bid, type: Integer
  field :player_2_bid, type: Integer
  belongs_to :game

  def calculate_result
    if self.player_1_bid > self.player_2_bid
      self.game.player_1.update_amount(self.player_1_bid)
      return 1
    elsif self.player_2_bid > self.player_1_bid
      self.game.player_2.update_amount(self.player_2_bid)
      return 2
    else
      self.game.draw_winner && self.game.change_draw_winner
    end
  end

end
