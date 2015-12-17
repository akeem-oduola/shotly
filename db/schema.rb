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

ActiveRecord::Schema.define(version: 20151217080618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clicks", force: :cascade do |t|
    t.integer  "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.inet     "ip"
    t.string   "country"
  end

  add_index "clicks", ["link_id"], name: "index_clicks_on_link_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "short_url"
    t.string   "url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "clicks_count", default: 0
    t.integer  "user_id"
    t.boolean  "active",       default: true
    t.boolean  "deleted"
  end

  add_index "links", ["short_url"], name: "index_links_on_short_url", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",                null: false
    t.string   "uid",                     null: false
    t.string   "name"
    t.string   "image_url"
    t.integer  "links_count", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree
end
