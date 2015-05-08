class AddQuotaToVirtualDomains < ActiveRecord::Migration
  def self.up
    add_column :virtual_domains, :quota, :integer, :limit => 8, :default => 0
  end

  def self.down
    remove_column :virtual_domains, :quota
  end
end
