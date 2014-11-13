class VirtualTransport < ActiveRecord::Base  
  validates :name, :uniqueness => true
  validates :name, :presence => true
  validates :name, :format => { :with => /^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$/, :message => "Please use a valid domain name" }
  validates :destination, :presence => true
end
