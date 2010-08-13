class Publication < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attachments
  
  validates_presence_of :title
  validates_presence_of :body
  
  accepts_nested_attributes_for :attachments, :reject_if => lambda { |attachment| attachment[:asset].blank? }, :allow_destroy => true
  
  scope :latest,    order("created_at DESC")
  scope :messages,  where("category = 0")
  scope :uploads,   where("category = 1")
  
  def attachment_attributes=(attachment_attributes)
    attachment_attributes.each do |attributes|
      attachments.build(attributes)
    end
  end
end
