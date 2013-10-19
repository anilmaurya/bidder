class Player
  include Mongoid::Document
  field :intial_amount, type: Integer
  field :current_amount, type: Integer
  field :bot, type: Boolean, default: false
  belongs_to :user
  has_many :bids
  delegate :username, to: :user, prefix: false

  def self.next_move
    10
  end

end
