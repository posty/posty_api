class CreateVirtualUsers < ActiveRecord::Migration
  def self.up
    create_table :virtual_users do |t|
      t.integer :virtual_domain_id
      t.string :password
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :virtual_users
  end
end
