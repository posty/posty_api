class CreateVirtualTransports < ActiveRecord::Migration
  def self.up
    create_table :virtual_transports do |t|
      t.string :name
      t.string :destination
      t.timestamps
    end
  end

  def self.down
    drop_table :virtual_transports
  end
end
