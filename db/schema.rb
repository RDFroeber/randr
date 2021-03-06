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

ActiveRecord::Schema.define(version: 20131024160937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "name",                      null: false
    t.boolean  "alive",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert"
  end

  create_table "books", force: true do |t|
    t.string   "title",          null: false
    t.integer  "author_id",      null: false
    t.string   "isbn",           null: false
    t.date     "published_date", null: false
    t.string   "img_url_sm"
    t.string   "img_url_lg"
    t.string   "buy_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "future_release"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id",                   null: false
    t.integer  "author_id",                 null: false
    t.boolean  "notify",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "libraries", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "book_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "libraries", ["user_id"], name: "index_libraries_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "name",            null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
