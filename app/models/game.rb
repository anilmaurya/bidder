class Game
  include Mongoid::Document
  field :result, type: String
  field :level, type: Integer
  field :practise, type: Boolean, default: false
  belongs_to :player_1, class_name: 'Player'
  belongs_to :player_2, class_name: 'Player'
end
