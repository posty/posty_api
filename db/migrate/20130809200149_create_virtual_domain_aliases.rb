class CreateVirtualDomainAliases < ActiveRecord::Migration
  def self.up
    create_table :virtual_domain_aliases do |t|
      t.integer :virtual_domain_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :virtual_domain_aliases
  end
end
