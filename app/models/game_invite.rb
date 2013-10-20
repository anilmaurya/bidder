class ValidInviteValidator < ActiveModel::Validator
  def validate(record)
    record_to_bevalidated = record.class.where(sender_user_id: record.sender_user, accept_status: nil).first
    if record_to_bevalidated
      record.errors[:base] << "Other invitation are still in pending state. Can't create new invitation"
    end 
  end
end

class GameInvite
  include Mongoid::Document
  include Mongoid::Timestamps 
  
  field :accept_status, type: Boolean 
 
  belongs_to :sender_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'  
  validates :sender_user_id, :receiver_user_id, presence: true
  validates_with ValidInviteValidator
    
end
