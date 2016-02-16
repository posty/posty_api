require 'folder'

class VirtualDomain < ActiveRecord::Base
  include Folder

  has_many :virtual_users, dependent: :destroy
  has_many :virtual_domain_aliases, dependent: :destroy

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, format: { with: /\A([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}\z/, message: 'Please use a valid domain name' }
  validate :name_unique

  after_update :move_folder, if: :name_changed?
  after_destroy :remove_folder

  def name_unique
    return unless VirtualDomainAlias.where(name: name).exists?

    errors[:name] << 'A domain alias with this name already exists'
  end

  def get_folder(domain = name)
    File.join MAIL_ROOT_FOLDER, domain
  end
end
