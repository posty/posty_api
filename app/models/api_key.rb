class ApiKey < ActiveRecord::Base
  attr_accessible :access_token, :expires_at, :active, :application
  before_create :generate_access_token

  validates :expires_at, presence: true
  validates :access_token, uniqueness: true

  scope :active, -> { where('expires_at > ? AND active = ?', Time.now, true) }

  private

  # rubocop:disable Loop
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
