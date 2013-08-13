class CreateUserAliasesView < ActiveRecord::Migration
  def self.up
    create_view :user_aliases_view, "select Concat(virtual_user_aliases.name, '@', virtual_domains.name) as source, Concat(virtual_users.name, '@', virtual_domains.name) as destination from virtual_user_aliases, virtual_users, virtual_domains where virtual_users.virtual_domain_id = virtual_domains.id AND virtual_user_aliases.virtual_user_id = virtual_users.id"
  end

  def self.down
    drop_view 
  end
end
