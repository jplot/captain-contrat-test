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

ActiveRecord::Schema.define(version: 20171217132928) do

  create_table "action_characters", force: :cascade do |t|
    t.integer "arena_action_id"
    t.integer "arena_character_id"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_action_id"], name: "index_action_characters_on_arena_action_id"
    t.index ["arena_character_id"], name: "index_action_characters_on_arena_character_id"
  end

  create_table "arena_actions", force: :cascade do |t|
    t.integer "arena_character_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_character_id"], name: "index_arena_actions_on_arena_character_id"
  end

  create_table "arena_characters", force: :cascade do |t|
    t.integer "arena_id"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state"
    t.index ["arena_id"], name: "index_arena_characters_on_arena_id"
    t.index ["character_id"], name: "index_arena_characters_on_character_id"
  end

  create_table "arenas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state"
    t.integer "min_characters", default: 2
    t.integer "max_characters", default: 2
  end

  create_table "assets", force: :cascade do |t|
    t.string "assetable_type"
    t.integer "assetable_id"
    t.integer "slug"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assetable_type", "assetable_id"], name: "index_assets_on_assetable_type_and_assetable_id"
  end

  create_table "character_items", force: :cascade do |t|
    t.integer "character_id"
    t.integer "user_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["character_id"], name: "index_character_items_on_character_id"
    t.index ["user_item_id"], name: "index_character_items_on_user_item_id"
  end

  create_table "characters", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "race_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["race_id"], name: "index_characters_on_race_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "item_slots", force: :cascade do |t|
    t.integer "item_id"
    t.integer "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_slots_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_items_on_slug", unique: true
  end

  create_table "races", force: :cascade do |t|
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_races_on_slug", unique: true
  end

  create_table "user_items", force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_user_items_on_item_id"
    t.index ["user_id"], name: "index_user_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
