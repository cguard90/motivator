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

ActiveRecord::Schema.define(version: 20160129160810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charities", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "category"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "setter_id",               null: false
    t.integer  "tender_id",               null: false
    t.integer  "charity_id",              null: false
    t.string   "title",                   null: false
    t.string   "description", limit: 300, null: false
    t.integer  "limit"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "goals", ["charity_id"], name: "index_goals_on_charity_id", using: :btree
  add_index "goals", ["setter_id"], name: "index_goals_on_setter_id", using: :btree
  add_index "goals", ["tender_id"], name: "index_goals_on_tender_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "goal_id",                null: false
    t.integer  "user_id",                null: false
    t.string   "content",    limit: 140, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.integer  "goal_id",                                 null: false
    t.string   "description", limit: 300,                 null: false
    t.date     "deadline",                                null: false
    t.boolean  "completed",               default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "milestones", ["goal_id"], name: "index_milestones_on_goal_id", using: :btree

  create_table "pledges", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "goal_id",    null: false
    t.integer  "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pledges", ["goal_id"], name: "index_pledges_on_goal_id", using: :btree
  add_index "pledges", ["user_id"], name: "index_pledges_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 20, null: false
    t.string   "email",                      null: false
    t.string   "password_digest",            null: false
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
