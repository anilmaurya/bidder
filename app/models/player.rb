class Player
  include Mongoid::Document
  field :current_amount, type: Integer
  field :bot, type: Boolean, default: false
  belongs_to :user
  has_many :bids
  delegate :username, to: :user, prefix: false
  validates :current_amount, numericality: { greater_than_or_equal_to: 0 }

  def next_move(opponent_amount, level)
    if self.current_amount == 0
      return 0
    elsif opponent_amount == 0
      return 1
    elsif level == 2
      return self.current_amount
    elsif level == 6 && self.current_amount < opponent_amount
      return self.current_amount
    elsif level == 6 && self.current_amount > opponent_amount
      return opponent_amount + 1
    elsif level == 5
      magic_number(opponent_amount)
    elsif level == 4 && self.current_amount < opponent_amount
      random_between_1_to_10
    elsif level == 4 && self.current_amount >= opponent_amount
      random_between_1_to_10
    elsif level == 3
      magic_number(opponent_amount)
    else
      random_number
    end
  end

  def update_amount(bid)
    self.update_attribute('current_amount', (self.current_amount - bid))
  end

  def update_amount!(bid)
    self.update_attributes(current_amount: (self.current_amount - bid))
  end

  def revert_amount(bid)
    self.update_attribute('current_amount', (self.current_amount + bid))
  end

  def random_between_1_to_15
    return (10..15).to_a.sample if self.current_amount > 15
    random_between_1_to_10
  end

  def random_between_1_to_10
    return (5..10).to_a.sample if self.current_amount > 10
    return (1..5).to_a.sample if self.current_amount > 5
    random_number
  end

  def magic_number(opponent_amount)
=begin
    if self.current_amount > opponent_amount
      number = ((self.current_amount - opponent_amount)..(self.current_amount - (self.current_amount - opponent_amount))).to_a.sample.to_i
      return number if number > 0
    end
    return self.current_amount - opponent_amount if (self.current_amount - opponent_amount ) > 0
    random_number
=end
    random_between_1_to_10
  end

  def random_number
    return (1..self.current_amount).to_a.sample if self.current_amount > 0
    return 0
  end
end
