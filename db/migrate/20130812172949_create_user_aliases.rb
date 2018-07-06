class CreateUserAliases < ActiveRecord::Migration
  def self.up
    create_table :virtual_user_aliases do |t|
      t.integer :virtual_user_id
      t.string :name
      t.timestamps
    end
    
    ActiveRecord::Base.connection.execute('drop view  aliases_view')
    drop_table :virtual_aliases
  end

  def self.down
    drop_table :virtual_user_aliases
  end
end
