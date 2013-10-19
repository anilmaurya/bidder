class Player
  include Mongoid::Document
  field :intial_amount, type: Integer
  field :current_amount, type: Integer
  belongs_to :user
end
