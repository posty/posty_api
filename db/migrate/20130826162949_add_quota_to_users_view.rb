class AddQuotaToUsersView < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute("drop view users_view")
    ActiveRecord::Base.connection.execute("create view users_view AS select Concat(virtual_users.name, '@', virtual_domains.name) as email, password, quota from virtual_users, virtual_domains where virtual_users.virtual_domain_id = virtual_domains.id")
  end

  def self.down
    ActiveRecord::Base.connection.execute("drop view users_view")
  end
end
