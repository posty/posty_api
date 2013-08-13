require 'digest/md5'

class VirtualUser < ActiveRecord::Base  
  belongs_to :virtual_domain
  has_many :virtual_user_aliases, :dependent => :destroy
  
  validates :name, :uniqueness => {:scope => :virtual_domain_id}
  validates :name, :format => { :with => /^[a-z0-9\-\.]+$/, :message => "Please use a valid user name" }
  validates :name, :presence => true
  validates :password, :presence => true, :length => { :minimum => 5, :maximum => 40 }
  validates :virtual_domain_id, :presence => true
#  validate :name_unique
  
  before_save :hash_password, :if => :password_changed?
    
  def name_unique
    if VirtualAlias.where("name = ? and virtual_domain_id = ?", name, virtual_domain_id).exists?
      errors[:email] << "A alias with this address already exist"
    end
  end
  
  def hash_password
    self.password = Digest::MD5.hexdigest(self.password)
  end
end