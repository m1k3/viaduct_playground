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

ActiveRecord::Schema.define(:version => 20100225142628) do

  create_table "articles", :force => true do |t|
    t.string "title", :null => false
    t.text   "body",  :null => false
  end

  add_index "articles", ["title"], :name => "index_articles_on_title"

  create_table "audio_recordings", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.binary   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "recording_id"
    t.string   "recording_type"
  end

  create_table "video_recordings", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.binary   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
