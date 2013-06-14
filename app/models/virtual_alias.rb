class VirtualAlias < ActiveRecord::Base
  belongs_to :virtual_domain
  
  validates :source, :uniqueness => {:scope => :virtual_domain_id}
  validates :source, :presence => true
  validates :source, :format => { :with => /^[a-z0-9\-\.]+$/, :message => "Please use a valid source" }
  validates :destination, :presence => true
  validates :destination, :format => { :with => /^[a-z0-9\-\.]+$/, :message => "Please use a valid destination" }
  validates :virtual_domain_id, :presence => true
  validate :source_and_destination_different
  validate :destination_exists
  validate :source_unique
  
  def source_and_destination_different
    if source == destination
      errors[:source] << "Source can not be the same as destination"
    end
  end
  
  def destination_exists
    unless VirtualUser.where("name = ? and virtual_domain_id = ?", destination, virtual_domain_id).exists?
      errors[:destination] << "Destination does not exist"
    end
  end
  
  def source_unique
    if VirtualUser.where("name = ? and virtual_domain_id = ?", source, virtual_domain_id).exists?
      errors[:source] << "A account with this address already exist"
    end
  end
end