# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100627182710) do

  create_table "authors", :force => true do |t|
    t.integer  "source_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "description"
    t.date     "print_date"
    t.string   "isbn"
    t.string   "edition"
    t.string   "publisher"
    t.string   "source_code_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conferences", :force => true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.integer  "venue_id"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "organization"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "feed_url"
    t.string   "etag"
    t.datetime "last_modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inquiries", :force => true do |t|
    t.string   "question"
    t.string   "audience"
    t.integer  "response_limit"
    t.datetime "question_open"
    t.datetime "question_closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inquiry_choices", :force => true do |t|
    t.string   "option_copy"
    t.string   "option_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.string   "title"
    t.integer  "source_id"
    t.integer  "topic_id"
    t.float    "ranking"
    t.string   "release"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "author"
    t.text     "summary"
    t.text     "content"
    t.datetime "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", :force => true do |t|
    t.integer  "source_id"
    t.string   "rate_name"
    t.float    "price"
    t.text     "description"
    t.boolean  "set_rate"
    t.string   "group_rate"
    t.datetime "rate_start"
    t.datetime "rate_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.text     "overview"
    t.string   "github_url"
    t.string   "rubyforge_url"
    t.string   "workingwithrails_url"
    t.string   "blog_url"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sources", :force => true do |t|
    t.integer  "resourceful_id"
    t.string   "resourceful_type"
    t.string   "title"
    t.string   "official_url"
    t.string   "primary_image_url"
    t.string   "primary_image_uid"
    t.string   "audience"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.integer  "supertopic_id"
    t.string   "name"
    t.string   "github_url"
    t.string   "rubyforge_url"
    t.string   "rubygem_url"
    t.string   "rdoc_url"
    t.string   "toolbox_category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email",                              :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["oauth_token"], :name => "index_users_on_oauth_token"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "region"
    t.string   "postal_code"
    t.text     "instructions"
    t.string   "hours"
    t.datetime "grand_opening"
    t.datetime "grand_closing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "meta"
    t.string   "stream_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "estimated_hours"
    t.float    "low_rate"
    t.float    "high_rate"
    t.string   "rate_scale"
    t.string   "work_license"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
