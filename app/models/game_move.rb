class GameMove
  include Mongoid::Document
  include Mongoid::Timestamps

  field :player_1_bid, type: Integer
  field :player_2_bid, type: Integer
  belongs_to :game

  def calculate_result
    if self.player_1_bid > self.player_2_bid
      update_player_1
      return 1
    elsif self.player_2_bid > self.player_1_bid
      update_player_2
      return 2
    else
      winner = self.game.draw_winner
      self.game.draw_winner == 1 ? update_player_1 : update_player_2
      self.game.change_draw_winner
      return winner
    end
  end

  def update_player_1
    self.game.player_1.update_amount(self.player_1_bid)
  end

  def update_player_2
    self.game.player_2.update_amount(self.player_2_bid)
  end
end
