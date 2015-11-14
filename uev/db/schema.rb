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

ActiveRecord::Schema.define(version: 20151114205854) do

  create_table "admins", force: :cascade do |t|
    t.string   "user"
    t.string   "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "candidatos", force: :cascade do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "number"
    t.string   "photo_url"
    t.integer  "cargo_id"
    t.integer  "ueg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cargos", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "ueg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eleitores", force: :cascade do |t|
    t.string   "name"
    t.string   "photo_url"
    t.string   "doc"
    t.integer  "status"
    t.integer  "ueg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uev_configs", force: :cascade do |t|
    t.integer "status"
    t.string  "desc"
  end

  create_table "votos", force: :cascade do |t|
    t.integer "value"
    t.integer "cargo_id"
  end

end
