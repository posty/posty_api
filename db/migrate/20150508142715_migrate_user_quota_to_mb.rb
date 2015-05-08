class MigrateUserQuotaToMb < ActiveRecord::Migration
  def self.up
    MEGABYTE = 1024.0 * 1024.0
    
    VirtualUser.all do |user|
      user.quota = user.quota / MEGABYTE
      user.save!
    end
  end

  def self.down
    MEGABYTE = 1024.0 * 1024.0
    
    VirtualUser.all do |user|
      user.quota = user.quota * MEGABYTE
      user.save!
    end
  end
end
