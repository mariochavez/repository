class Attachment < ActiveRecord::Base
  belongs_to :publication
  
  has_attached_file :asset, :styles => { :medium => "300x300#", :thumb => "50x50#" }
  
  validates_attachment_presence :asset
  validates_attachment_content_type :asset, 
    :content_type => ['image/jpeg', 'image/pjpeg', 
                                     'image/jpg', 'image/png']
end
