class CreateVirtualAliases < ActiveRecord::Migration
  def self.up
    create_table :virtual_aliases do |t|
      t.integer :virtual_domain_id
      t.string :source
      t.string :destination
      t.timestamps
    end
  end

  def self.down
    drop_table :virtual_aliases if table_exists? :virtual_aliases
  end
end
