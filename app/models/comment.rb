class Comment < ActiveRecord::Base
  belongs_to :publication
  belongs_to :user
  
  validates_presence_of :body
end
