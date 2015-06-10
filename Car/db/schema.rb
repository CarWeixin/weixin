# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20150610130545) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "password_md5"
    t.integer  "user_id"
    t.integer  "user_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"
  add_index "accounts", ["username"], :name => "index_accounts_on_username"

  create_table "check_in_logs", :force => true do |t|
    t.integer  "staff_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "check_in_logs", ["staff_id"], :name => "index_check_in_logs_on_staff_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "companies", ["name"], :name => "index_companies_on_name"

  create_table "contents", :force => true do |t|
    t.string "content",   :limit => 256
    t.string "content_2", :limit => 256
    t.string "first",     :limit => 256
    t.string "second",    :limit => 256
    t.string "third",     :limit => 256
    t.string "fourth",    :limit => 256
    t.string "fifth",     :limit => 256
  end

  create_table "digger_check_lists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "digger_check_logs", :force => true do |t|
    t.integer  "type"
    t.integer  "manager_id"
    t.string   "digger_id"
    t.string   "checked"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "digger_check_logs", ["digger_id"], :name => "index_digger_check_logs_on_digger_id"

  create_table "digger_infos", :force => true do |t|
    t.string   "digger_id"
    t.integer  "workplace_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "disburdens", :force => true do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "distances", :force => true do |t|
    t.integer "from", :null => false
    t.integer "to",   :null => false
    t.float   "dis",  :null => false
  end

  create_table "driver_infos", :force => true do |t|
    t.string   "url"
    t.string   "plate_num"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "workplace_id"
    t.integer  "manager_id"
    t.integer  "endplace_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "manager_end_id"
    t.integer  "driver"
  end

  create_table "gas_logs", :force => true do |t|
    t.integer "truck_id"
    t.integer "num"
  end

  create_table "infomations", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "start_time"
    t.string   "start"
    t.string   "end"
    t.string   "driver"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "managers", :force => true do |t|
    t.integer  "num"
    t.string   "name"
    t.string   "work_id"
    t.integer  "workplace_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "avatar_url"
    t.boolean  "if_gas"
  end

  add_index "managers", ["work_id"], :name => "index_managers_on_work_id"

  create_table "out_logs", :force => true do |t|
    t.integer "workplace_id"
    t.integer "manager_id"
    t.integer "out_manager_id"
    t.string  "plate_num",      :limit => 32
    t.string  "url",            :limit => 64
    t.time    "created_at"
    t.time    "updated_at"
  end

  create_table "out_managers", :force => true do |t|
    t.integer "company_id",               :null => false
    t.string  "IDcard",     :limit => 32
    t.string  "weixin",     :limit => 64
    t.string  "name",       :limit => 32
  end

  create_table "place_loggings", :force => true do |t|
    t.integer  "place_id"
    t.integer  "place_log_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "place_logs", :force => true do |t|
    t.integer  "workplace_id"
    t.datetime "end_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "place_logs", ["workplace_id"], :name => "index_place_logs_on_workplace_id"

  create_table "places", :force => true do |t|
    t.integer  "workplace_id"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "places", ["workplace_id"], :name => "index_places_on_workplace_id"

  create_table "staffs", :force => true do |t|
    t.string   "name"
    t.string   "work_id"
    t.integer  "workplace_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "staffs", ["workplace_id"], :name => "index_staffs_on_workplace_id"

  create_table "truck_infos", :force => true do |t|
    t.integer  "truckuser_id"
    t.integer  "truck_id"
    t.integer  "start_id"
    t.integer  "end_id"
    t.string   "url"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "start_place"
    t.string   "end_place"
    t.integer  "manager_confirm", :default => 0, :null => false
    t.integer  "grab_confirm",    :default => 0, :null => false
    t.integer  "manager_id"
  end

  create_table "truck_logs", :force => true do |t|
    t.integer  "truck_id"
    t.integer  "truckuser_id"
    t.integer  "finish_type"
    t.text     "remark"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "truck_logs", ["truck_id"], :name => "index_truck_logs_on_truck_id"
  add_index "truck_logs", ["truckuser_id"], :name => "index_truck_logs_on_truckuser_id"

  create_table "truckdrivers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "information"
  end

  create_table "trucks", :force => true do |t|
    t.string   "plate_num"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "weixin"
    t.string   "num"
    t.string   "take_num"
  end

  add_index "trucks", ["id"], :name => "id", :unique => true

  create_table "truckusers", :force => true do |t|
    t.string   "name"
    t.string   "work_id"
    t.string   "avatar_url"
    t.integer  "truck_id"
    t.datetime "last_acc_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "weixin"
    t.string   "IDcard"
  end

  add_index "truckusers", ["truck_id"], :name => "index_truckusers_on_truck_id"

  create_table "versions", :force => true do |t|
    t.string   "num"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "workplaces", :force => true do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "gas",        :default => 0, :null => false
  end

end
