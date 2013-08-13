class AddQuotaToVirtualUsers < ActiveRecord::Migration
  def self.up
    add_column :virtual_users, :quota, :integer, :limit => 8, :default => 0
  end

  def self.down
    remove_column :virtual_users, :quota
  end
end
