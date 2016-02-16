class VirtualDomainAlias < ActiveRecord::Base
  belongs_to :virtual_domain

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, format: { with: /\A([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}\z/, message: 'Please use a valid domain name' }
  validates :virtual_domain_id, presence: true
  validate :name_unique

  def name_unique
    return unless VirtualDomain.where(name: name).exists?

    errors[:name] << 'A domain with this name already exists'
  end
end
