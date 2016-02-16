# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150519141623) do

  create_table "api_keys", :force => true do |t|
    t.string   "access_token",                   :null => false
    t.boolean  "active",       :default => true, :null => false
    t.datetime "expires_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.index ["access_token"], :name => "index_api_keys_on_access_token"
  end

  create_table "virtual_domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["name"], :name => "index_virtual_domains_on_name"
  end

  create_table "virtual_domain_aliases", :force => true do |t|
    t.integer  "virtual_domain_id"
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.index ["name"], :name => "index_virtual_domain_aliases_on_name"
    t.index ["virtual_domain_id"], :name => "fk__virtual_domain_aliases_virtual_domain_id"
    t.index ["virtual_domain_id"], :name => "index_virtual_domain_aliases_on_virtual_domain_id"
    t.foreign_key ["virtual_domain_id"], "virtual_domains", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_virtual_domain_aliases_virtual_domain_id"
  end

  create_view "domain_aliases_view", "SELECT pg_catalog.concat('@', virtual_domain_aliases.name) AS source, pg_catalog.concat('@', virtual_domains.name) AS destination FROM virtual_domain_aliases, virtual_domains WHERE (virtual_domain_aliases.virtual_domain_id = virtual_domains.id)", :force => true
  create_table "virtual_users", :force => true do |t|
    t.integer  "virtual_domain_id"
    t.string   "password"
    t.string   "name"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "quota",             :limit => 8, :default => 0
    t.index ["name"], :name => "index_virtual_users_on_name"
    t.index ["virtual_domain_id"], :name => "fk__virtual_users_virtual_domain_id"
    t.index ["virtual_domain_id"], :name => "index_virtual_users_on_virtual_domain_id"
    t.foreign_key ["virtual_domain_id"], "virtual_domains", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_virtual_users_virtual_domain_id"
  end

  create_table "virtual_user_aliases", :force => true do |t|
    t.integer  "virtual_user_id"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.index ["name"], :name => "index_virtual_user_aliases_on_name"
    t.index ["virtual_user_id"], :name => "fk__virtual_user_aliases_virtual_user_id"
    t.index ["virtual_user_id"], :name => "index_virtual_user_aliases_on_virtual_user_id"
    t.foreign_key ["virtual_user_id"], "virtual_users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_virtual_user_aliases_virtual_user_id"
  end

  create_view "user_aliases_view", "SELECT pg_catalog.concat(virtual_user_aliases.name, '@', virtual_domains.name) AS source, pg_catalog.concat(virtual_users.name, '@', virtual_domains.name) AS destination FROM virtual_user_aliases, virtual_users, virtual_domains WHERE ((virtual_users.virtual_domain_id = virtual_domains.id) AND (virtual_user_aliases.virtual_user_id = virtual_users.id))", :force => true
  create_view "users_view", "SELECT pg_catalog.concat(virtual_users.name, '@', virtual_domains.name) AS email, virtual_users.password, virtual_users.quota FROM virtual_users, virtual_domains WHERE (virtual_users.virtual_domain_id = virtual_domains.id)", :force => true
  create_table "virtual_transports", :force => true do |t|
    t.string   "name"
    t.string   "destination"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.index ["name"], :name => "index_virtual_transports_on_name"
  end

end
