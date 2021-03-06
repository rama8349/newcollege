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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170105105010) do

  create_table "attendances", force: :cascade do |t|
    t.date     "attend_date"
    t.string   "attend_day",  limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "created_by",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "city_name",       limit: 20
    t.integer  "state_id",        limit: 4,  null: false
    t.integer  "created_by",      limit: 4
    t.integer  "updated_by",      limit: 4
    t.string   "status",          limit: 15
    t.integer  "regional_id",     limit: 4,  null: false
    t.string   "city_short_form", limit: 15
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "colleges", force: :cascade do |t|
    t.string   "college_name",       limit: 255
    t.string   "college_short_name", limit: 255
    t.string   "address",            limit: 255
    t.date     "establish_date"
    t.string   "status",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "country_name",       limit: 25
    t.integer  "created_by",         limit: 4
    t.integer  "updated_by",         limit: 4
    t.string   "country_short_form", limit: 15
    t.string   "status",             limit: 15
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "middle_name",     limit: 255,                    null: false
    t.string   "last_name",       limit: 255,                    null: false
    t.string   "nick_name",       limit: 255,                    null: false
    t.string   "login_name",      limit: 255,                    null: false
    t.string   "address1",        limit: 255
    t.string   "address2",        limit: 255
    t.string   "address3",        limit: 255
    t.string   "gender",          limit: 255
    t.string   "date_of_birth",   limit: 255
    t.string   "contact_number",  limit: 255,                    null: false
    t.string   "marital_status",  limit: 255
    t.string   "hobbies",         limit: 255
    t.integer  "role_id",         limit: 4,                      null: false
    t.integer  "city_id",         limit: 4,                      null: false
    t.integer  "created_by",      limit: 4
    t.integer  "updated_by",      limit: 4
    t.string   "status",          limit: 255, default: "Active"
    t.string   "hashed_password", limit: 255
    t.string   "salt",            limit: 255
    t.string   "email_id",        limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "regionals", force: :cascade do |t|
    t.string   "region_name", limit: 255
    t.integer  "created_by",  limit: 4
    t.integer  "updated_by",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_name",       limit: 25
    t.string   "role_short_name", limit: 25
    t.integer  "created_by",      limit: 4
    t.integer  "updated_by",      limit: 4
    t.string   "status",          limit: 15
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "state_name",       limit: 20
    t.integer  "country_id",       limit: 4,  null: false
    t.integer  "created_by",       limit: 4
    t.integer  "updated_by",       limit: 4
    t.string   "status",           limit: 15
    t.string   "state_short_form", limit: 15
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "sur_name",         limit: 255
    t.string   "email",            limit: 255
    t.string   "confirm_email",    limit: 255
    t.string   "pasword",          limit: 255
    t.integer  "day",              limit: 4
    t.integer  "month",            limit: 4
    t.integer  "year",             limit: 4
    t.string   "gender",           limit: 255
    t.boolean  "upload_photo"
    t.date     "attend_date"
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.string   "type_of_login",    limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
