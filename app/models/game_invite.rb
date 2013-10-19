class GameInvite
  include Mongoid::Document
  include Mongoid::Timestamps 
  
  field :accept_status, type: Boolean 
 
  belongs_to :sender_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'   
end
