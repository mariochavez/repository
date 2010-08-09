class Publication < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attachments
  
  validates_presence_of :title
  validates_presence_of :body
  
  def attachment_attributes=(attachment_attributes)
    attachment_attributes.each do |attributes|
      attachments.build(attributes)
    end
  end
end
