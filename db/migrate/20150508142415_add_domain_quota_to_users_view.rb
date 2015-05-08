class AddDomainQuotaToUsersView < ActiveRecord::Migration
  def self.up
    drop_view :users_view
    create_view :users_view, "SELECT CONCAT(virtual_users.name, '@', virtual_domains.name) AS email, password, virtual_domains.quota AS quota_domain, virtual_users.quota FROM virtual_users, virtual_domains WHERE virtual_users.virtual_domain_id = virtual_domains.id"
  end

  def self.down
    drop_view :users_view
  end
end
