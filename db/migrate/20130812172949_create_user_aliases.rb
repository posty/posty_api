class CreateUserAliases < ActiveRecord::Migration
  def self.up
    create_table :virtual_user_aliases do |t|
      t.integer :virtual_user_id
      t.string :name
      t.timestamps
    end
    
    drop_table :virtual_aliases
    drop_view :aliases_view
  end

  def self.down
    drop_table :virtual_user_aliases
  end
end
