class ApiKey < ActiveRecord::Base
  attr_accessible :access_token, :expires_at, :active, :application
  before_create :generate_access_token
  before_create :set_expiration

  scope :active, lambda {where('expires_at > ? AND active = 1', Time.now)}
 
  def expired?
    DateTime.now >= self.expires_at
  end
  
  def expire
    self.update_attributes(:expires_at => DateTime.now)
  end
  
  def disable
    self.update_attributes(:active => false)
  end
 
  private
	def generate_access_token
		begin
			self.access_token = SecureRandom.hex
		end while self.class.exists?(access_token: access_token)
	end

  def set_expiration
    self.expires_at = DateTime.now + 5.years
  end
end