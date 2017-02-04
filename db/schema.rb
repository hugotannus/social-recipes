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

ActiveRecord::Schema.define(version: 20170204045832) do

  create_table "cuisines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorited_recipes", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "favorite_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["favorite_id"], name: "index_favorited_recipes_on_favorite_id"
    t.index ["follower_id", "favorite_id"], name: "index_favorited_recipes_on_follower_id_and_favorite_id", unique: true
    t.index ["follower_id"], name: "index_favorited_recipes_on_follower_id"
  end

  create_table "kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "title"
    t.integer  "portions"
    t.integer  "prep_time"
    t.integer  "difficulty"
    t.text     "ingredients"
    t.text     "directions"
    t.integer  "cuisine_id"
    t.integer  "kind_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "picture"
    t.integer  "user_id"
    t.index ["cuisine_id"], name: "index_recipes_on_cuisine_id"
    t.index ["kind_id"], name: "index_recipes_on_kind_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "city"
    t.string   "facebook"
    t.string   "twitter"
  end

end
