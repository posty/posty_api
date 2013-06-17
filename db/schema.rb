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

ActiveRecord::Schema.define(:version => 20130614141749) do

  create_table "virtual_domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "virtual_aliases", :force => true do |t|
    t.integer  "virtual_domain_id"
    t.string   "source"
    t.string   "destination"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.index ["virtual_domain_id"], :name => "index_virtual_aliases_on_virtual_domain_id"
    t.foreign_key ["virtual_domain_id"], "virtual_domains", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "virtual_aliases_ibfk_1"
  end

  create_view "aliases_view", "select concat(`virtual_aliases`.`source`,'@',`virtual_domains`.`name`) AS `source`,concat(`virtual_aliases`.`destination`,'@',`virtual_domains`.`name`) AS `destination` from `virtual_aliases` join `virtual_domains` where (`virtual_aliases`.`virtual_domain_id` = `virtual_domains`.`id`)", :force => true
  create_table "virtual_users", :force => true do |t|
    t.integer  "virtual_domain_id"
    t.string   "password"
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.index ["virtual_domain_id"], :name => "index_virtual_users_on_virtual_domain_id"
    t.foreign_key ["virtual_domain_id"], "virtual_domains", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "virtual_users_ibfk_1"
  end

  create_view "users_view", "select concat(`virtual_users`.`name`,'@',`virtual_domains`.`name`) AS `email`,`virtual_users`.`password` AS `password` from `virtual_users` join `virtual_domains` where (`virtual_users`.`virtual_domain_id` = `virtual_domains`.`id`)", :force => true
end
