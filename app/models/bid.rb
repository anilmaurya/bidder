class Bid
  include Mongoid::Document
  field :amount
  belongs_to :player
  belongs_to :game
end
