class CreateVirtualDomains < ActiveRecord::Migration
  def self.up
    create_table :virtual_domains do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :virtual_domains
  end
end
