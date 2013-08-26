class AddQuotaToUsersView < ActiveRecord::Migration
  def self.up
    drop_view :users_view
    create_view :users_view, "select Concat(virtual_users.name, '@', virtual_domains.name) as email, password, quota from virtual_users, virtual_domains where virtual_users.virtual_domain_id = virtual_domains.id"
  end

  def self.down
    drop_view :users_view
  end
end
