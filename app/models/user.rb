class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  				  :first_name, :last_name, :profile_name

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, 
                           uniqueness: true,
                           format: {
                           with: /^[a-zA-Z0-9_-]*$/,
                           message: 'Must be formatted correctly.'
                           }

  has_many :statuses
  has_many :events #This is linking a user to many events.
  			  
  def full_name
  	first_name + " " + last_name
  end

  def gravatar_url
    stripped_email = email.strip #remove any spaces
    downcased_email = stripped_email.downcase #make everything lowercase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}" # #{} will replace the listed value with the variable
  end
end
