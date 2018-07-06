class AddDomainAliasesViews < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute(
      "create view domain_aliases_view AS select Concat('@', virtual_domain_aliases.name) as source, Concat('@', virtual_domains.name) as destination from virtual_domain_aliases, virtual_domains where virtual_domain_aliases.virtual_domain_id = virtual_domains.id"
    )
  end

  def self.down
    ActiveRecord::Base.connection.execute(
      "drop view domain_aliases_view"
    )
  end
end
