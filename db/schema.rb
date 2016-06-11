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

ActiveRecord::Schema.define(version: 20160609080341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deleted_results", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "repo_id"
    t.string   "repo_title"
    t.string   "repo_url"
    t.string   "repo_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "repo_stars"
    t.integer  "search_items_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "saved_results", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "repo_id"
    t.string   "repo_title"
    t.string   "repo_url"
    t.string   "repo_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "repo_stars"
    t.integer  "search_items_id"
  end

  create_table "search_items", force: :cascade do |t|
    t.string   "topic"
    t.string   "language"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "project_id"
    t.datetime "date_request_cache"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
