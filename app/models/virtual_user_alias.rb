class VirtualUserAlias < ActiveRecord::Base
  belongs_to :virtual_user

  # TODO: name uniqueness with scope is nonsense
  validates :name, uniqueness: { scope: :virtual_user_id }

  validates :name, presence: true
  validates :name, format: { with: /\A[a-z0-9\-\.]+\z/, message: 'Please use a valid source' }
  validates :virtual_user_id, presence: true
  # validate :name_unique

  def name_unique
    return unless VirtualUser.where(name: name, virtual_domain_id: virtual_domain_id).exists?

    errors[:source] << 'A account with this address already exist'
  end
end
