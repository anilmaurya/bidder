class Player
  include Mongoid::Document
  field :current_amount, type: Integer
  field :bot, type: Boolean, default: false
  belongs_to :user
  has_many :bids
  delegate :username, to: :user, prefix: false

  def self.next_move(opponent_amount, level)
    case level
    when 2
      return self.current_amount
    when 3
      return 8
    else
      return 10
    end
  end

  def update_amount(bid)
    self.update_attributes(current_amount: (self.current_amount - bid))
  end
end
