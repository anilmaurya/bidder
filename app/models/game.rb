class Game
  include Mongoid::Document
  field :result, type: String
  field :level, type: Integer
  field :practise, type: Boolean, default: false
  field :draw_winner, type: Integer, default: 1
  belongs_to :player_1, class_name: 'Player'
  belongs_to :player_2, class_name: 'Player'

  def change_draw_winner
    self.draw_winner = self.draw_winner == 1 ? 2 : 1
  end

end
