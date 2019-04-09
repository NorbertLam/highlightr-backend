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

ActiveRecord::Schema.define(version: 2019_04_08_183917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "highlights", force: :cascade do |t|
    t.integer "vod_id"
    t.integer "twitch_id"
    t.string "start"
    t.string "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "streamers", force: :cascade do |t|
    t.string "twitch_id"
    t.string "login"
    t.string "display_name"
    t.string "broadcaster_type"
    t.string "description"
    t.string "profile_image_url"
    t.string "offline_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "username"
    t.string "first_name"
    t.string "profile_picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vods", force: :cascade do |t|
    t.integer "streamer_id"
    t.integer "twitch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
