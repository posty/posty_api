class VirtualDomain < ActiveRecord::Base
  has_many :virtual_users, :dependent => :destroy
  has_many :virtual_domain_aliases, :dependent => :destroy
  
  validates :name, :uniqueness => true
  validates :name, :presence => true
  validates :name, :format => { :with => /^[a-z0-9\-]{2,}\.[a-z0-9]{2,}$/, :message => "Please use a valid domain name" }
end