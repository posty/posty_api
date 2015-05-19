class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :api_keys, :access_token
    add_index :virtual_domain_aliases, :virtual_domain_id
    add_index :virtual_domain_aliases, :name
    add_index :virtual_domains, :name
    add_index :virtual_transports, :name
    add_index :virtual_user_aliases, :virtual_user_id
    add_index :virtual_user_aliases, :name
    add_index :virtual_users, :virtual_domain_id
    add_index :virtual_users, :name
  end

  def self.down
    remove_index :api_keys, :access_token
    remove_index :virtual_domain_aliases, :virtual_domain_id
    remove_index :virtual_domain_aliases, :name
    remove_index :virtual_domains, :name
    remove_index :virtual_transports, :name
    remove_index :virtual_user_aliases, :virtual_user_id
    remove_index :virtual_user_aliases, :name
    remove_index :virtual_users, :virtual_domain_id
    remove_index :virtual_users, :name
  end
end
