class AddViews < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute(
      "create view users_view AS select Concat(virtual_users.name, '@', virtual_domains.name) as email, password from virtual_users, virtual_domains where virtual_users.virtual_domain_id = virtual_domains.id"
    )
    ActiveRecord::Base.connection.execute(
      "create view aliases_view AS select Concat(virtual_aliases.source, '@', virtual_domains.name) as source, Concat(virtual_aliases.destination, '@', virtual_domains.name) as destination from virtual_aliases, virtual_domains where virtual_aliases.virtual_domain_id = virtual_domains.id"
    )
  end

  def self.down
    ActiveRecord::Base.connection.execute('drop view users_view')
    ActiveRecord::Base.connection.execute('drop view aliases_view')
  end
end
