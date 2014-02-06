class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :password, :password_confirmation, :remember_me, :username, :guest, :image, :name, :email, :uid, :provider

  #validates :username, uniqueness: true
  has_many :players
  ## Database authenticatable
  field :guest, type: Boolean, default: false
  field :username, type: String
  field :encrypted_password, :type => String, :default => ""
  field :name, type: String
  field :email, type: String

  #Profile Pic
  mount_uploader :image, ImageUploader 

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  field :provider, type: String
  field :uid, type: String
  
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:username)
      where(conditions).where(:username => login.downcase).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first 
    unless user 
      user = User.create(name:auth.extra.raw_info.name, provider:auth.provider, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20], username: auth.info.nickname )
      user.remote_image_url = auth.extra.raw_info.profile_image_url
      user.save!
    end 
    user 
  end

end
