class ApiKey < ActiveRecord::Base
  attr_accessible :access_token, :expires_at, :active, :application
  before_create :generate_access_token
  before_create :set_expiration
 
  def expired?
    DateTime.now >= self.expires_at
  end
 
  private
  	def generate_access_token
  		begin
  			self.access_token = SecureRandom.hex
  		end while self.class.exists?(access_token: access_token)
  	end
 
    def set_expiration
      self.expires_at = DateTime.now+30
    end
    
    def expire
      self.expires_at = DateTime.now
    end
    
    def disable
      self.active = false
    end
end