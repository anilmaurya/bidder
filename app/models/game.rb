class Game
  include Mongoid::Document
  field :result, type: String
  field :level, type: Integer
  belongs_to :player_1, class_name: 'Player'
  belongs_to :player_2, class_name: 'Player'
end
