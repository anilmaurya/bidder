class GameMove
  include Mongoid::Document
  include Mongoid::Timestamps 
  
  field :player_1_bid, type: Integer
  field :player_2_bid, type: Integer
end
