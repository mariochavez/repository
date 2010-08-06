class User < ActiveRecord::Base
  has_many :publications
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50>" }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar
end
