class Link < ActiveRecord::Base
  belongs_to :user
  validates :url_link, url: true
  
  
end
