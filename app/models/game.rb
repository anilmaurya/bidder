class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :result, type: String
  field :level, type: Integer
  field :practise, type: Boolean, default: false
  field :draw_winner, type: Integer, default: 1
  belongs_to :player_1, class_name: 'Player'
  belongs_to :player_2, class_name: 'Player'

  def change_draw_winner
    self.draw_winner = self.draw_winner == 1 ? 2 : 1
    self.save
  end

  def update_level(result)
    case result
    when 1
      self.level -= 1
    when 2
      self.level += 1
    end
    self.save
  end
end
