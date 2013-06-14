class AddViews < ActiveRecord::Migration
  def self.up
    create_view :users_view, "select Concat(virtual_users.name, '@', virtual_domains.name) as email, password from virtual_users, virtual_domains where virtual_users.virtual_domain_id = virtual_domains.id"
    create_view :aliases_view, "select Concat(virtual_aliases.source, '@', virtual_domains.name) as source, Concat(virtual_aliases.destination, '@', virtual_domains.name) as destination from virtual_aliases, virtual_domains where virtual_aliases.virtual_domain_id = virtual_domains.id"
  end

  def self.down
    drop_view :users_view
    drop_view :aliases_view
  end
end
