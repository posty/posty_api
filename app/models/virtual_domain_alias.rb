class VirtualDomainAlias < ActiveRecord::Base
  belongs_to :virtual_domain
  
  validates :name, :uniqueness => true
  validates :name, :presence => true
  validates :name, :format => { :with => /^[a-z0-9\-]{2,}\.[a-z0-9]{2,}$/, :message => "Please use a valid domain name without @" }
  validates :virtual_domain_id, :presence => true
#  validate :name_unique
  
  def name_unique
    if VirtualDomain.where("name = ?", name).exists?
      errors[:name] << "A domain with this name already exists"
    end
  end
end