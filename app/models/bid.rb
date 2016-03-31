class Bid
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :amount
  belongs_to :player
  belongs_to :game
end
