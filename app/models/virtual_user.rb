require 'digest/sha2'
require 'folder'

class VirtualUser < ActiveRecord::Base
  include Folder

  belongs_to :virtual_domain
  has_many :virtual_user_aliases, dependent: :destroy

  validates :name, uniqueness: { scope: :virtual_domain_id }
  validates :name, format: { with: /\A[a-z0-9\-\.\_]+\z/, message: 'Please use a valid user name' }
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :virtual_domain_id, presence: true
  # validate :name_unique

  before_save :hash_password, if: :password_changed?
  after_create :create_folder
  after_update :move_folder, if: :name_changed?
  after_destroy :remove_folder

  # TODO: fix name_unique virtual_domain_id is not present
  def name_unique
    if VirtualUserAlias.where('name = ? and virtual_domain_id = ?', name, virtual_domain.id).exists?
      errors[:email] << 'A alias with this address already exist'
    end
  end

  def hash_password
    self.password = password.crypt("$6$#{SecureRandom.hex(10)}")
  end

  def get_folder(user = name)
    MAIL_ROOT_FOLDER + '/' + virtual_domain.name + '/' + user
  end

  def create_folder
    complete_path = get_folder + '/' + STORAGE_CLASS
    folder_array = complete_path.gsub(MAIL_ROOT_FOLDER + '/', '').split('/')

    if ENV['RACK_ENV'] == 'production'
      if File.directory?(get_folder)
        error!('A folder with this name already exists.', 400)
      else
        FileUtils.mkdir_p complete_path
        change_permissions(folder_array)
      end
    end
  end
end
