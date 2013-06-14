class VirtualUser < ActiveRecord::Base  
  belongs_to :virtual_domain
  
  validates :name, :uniqueness => {:scope => :virtual_domain_id}
  validates :name, :format => { :with => /^[a-z0-9\-\.]+$/, :message => "Please use a valid user name" }
  validates :name, :presence => true
  validates :password, :presence => true
  validates :virtual_domain_id, :presence => true
  validate :name_unique
    
  def name_unique
    if VirtualAlias.where("source = ? and virtual_domain_id = ?", name, virtual_domain_id).exists?
      errors[:email] << "A alias with this address already exist"
    end
  end
end