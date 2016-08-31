class VirtualUserAlias < ActiveRecord::Base
  belongs_to :virtual_user

  # TODO: name uniqueness with scope is nonsense
  validates :name, uniqueness: { scope: :virtual_user_id }

  validates :name, presence: true
  validates :name, format: { with: /^[a-z0-9\-\.\_]+$/, message: 'Please use a valid source' }
  validates :virtual_user_id, presence: true
  # validate :name_unique

  def name_unique
    if VirtualUser.where('name = ? and virtual_domain_id = ?', name, virtual_domain_id).exists?
      errors[:source] << 'A account with this address already exist'
    end
  end
end
