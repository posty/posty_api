class CreateUserAliases < ActiveRecord::Migration
  def self.up
    create_table :virtual_user_aliases do |t|
      t.integer :virtual_user_id
      t.string :name
      t.timestamps null: false
    end

    drop_view  :aliases_view, if_exists: true
    drop_table :virtual_aliases if table_exists? :virtual_aliases
  end

  def self.down
    drop_table :virtual_user_aliases
  end
end
