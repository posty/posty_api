class AddDomainAliasesViews < ActiveRecord::Migration
  def self.up
    create_view :domain_aliases_view, "select Concat('@', virtual_domain_aliases.name) as source, Concat('@', virtual_domains.name) as destination from virtual_domain_aliases, virtual_domains where virtual_domain_aliases.virtual_domain_id = virtual_domains.id"
  end

  def self.down
    drop_view :domain_aliases_view, if_exists: true
  end
end
