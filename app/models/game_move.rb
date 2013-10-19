class GameMove
  include Mongoid::Document
  field :player_1_bid, type: Integer
  field :player_2_bid, type: Integer
end
