class MigrateUserQuotaToMb < ActiveRecord::Migration
  MEGABYTE = 1024.0 * 1024.0

  def self.up
    VirtualUser.all do |user|
      user.quota = user.quota / MEGABYTE
      user.save!
    end
  end

  def self.down
    VirtualUser.all do |user|
      user.quota = user.quota * MEGABYTE
      user.save!
    end
  end
end
