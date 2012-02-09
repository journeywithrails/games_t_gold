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

ActiveRecord::Schema.define(:version => 20090611094030) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action",     :limit => 50
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
  end

  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "ads", :force => true do |t|
    t.string   "name"
    t.text     "html"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "location"
    t.boolean  "published",        :default => false
    t.boolean  "time_constrained", :default => false
    t.string   "audience",         :default => "all"
  end

  create_table "assets", :force => true do |t|
    t.string   "filename"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.integer  "size"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "thumbnail"
    t.integer  "parent_id"
  end

  create_table "categories", :force => true do |t|
    t.string "name"
    t.text   "tips"
    t.string "new_post_text"
    t.string "nav_text"
  end

  create_table "choices", :force => true do |t|
    t.integer "poll_id"
    t.string  "description"
    t.integer "votes_count", :default => 0
  end

  create_table "clippings", :force => true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.string   "image_url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "favorited_count", :default => 0
  end

  add_index "clippings", ["created_at"], :name => "index_clippings_on_created_at"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.datetime "created_at",                                     :null => false
    t.integer  "commentable_id",                 :default => 0,  :null => false
    t.string   "commentable_type", :limit => 15, :default => "", :null => false
    t.integer  "user_id",                        :default => 0,  :null => false
    t.integer  "recipient_id"
    t.text     "comment"
    t.string   "author_name"
    t.string   "author_email"
    t.string   "author_url"
    t.string   "author_ip"
  end

  add_index "comments", ["user_id"], :name => "fk_comments_user"
  add_index "comments", ["recipient_id"], :name => "index_comments_on_recipient_id"
  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"

  create_table "contests", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "begin"
    t.datetime "end"
    t.text     "raw_post"
    t.text     "post"
    t.string   "banner_title"
    t.string   "banner_subtitle"
  end

  create_table "countries", :force => true do |t|
    t.string "name"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.integer  "metro_area_id"
    t.string   "location"
  end

  create_table "favorites", :force => true do |t|
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "favoritable_type"
    t.integer  "favoritable_id"
    t.integer  "user_id"
    t.string   "ip_address",       :default => ""
  end

  add_index "favorites", ["user_id"], :name => "fk_favorites_user"

  create_table "forums", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.integer "topics_count",     :default => 0
    t.integer "sb_posts_count",   :default => 0
    t.integer "position"
    t.text    "description_html"
    t.string  "owner_type"
    t.integer "owner_id"
  end

  create_table "friendship_statuses", :force => true do |t|
    t.string "name"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "friend_id"
    t.integer  "user_id"
    t.boolean  "initiator",            :default => false
    t.datetime "created_at"
    t.integer  "friendship_status_id"
  end

  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"
  add_index "friendships", ["friendship_status_id"], :name => "index_friendships_on_friendship_status_id"

  create_table "homepage_features", :force => true do |t|
    t.datetime "created_at"
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.datetime "updated_at"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
  end

  create_table "invitations", :force => true do |t|
    t.string   "email_addresses"
    t.string   "message"
    t.string   "user_id"
    t.datetime "created_at"
  end

  create_table "match_players", :force => true do |t|
    t.integer  "match_id"
    t.integer  "position"
    t.integer  "player_id"
    t.string   "player_type"
    t.string   "score",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_players", ["match_id", "position"], :name => "index_match_players_on_match_id_and_position"
  add_index "match_players", ["player_id", "player_type"], :name => "index_match_players_on_player_id_and_player_type"

  create_table "matches", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "position"
    t.datetime "schedule"
    t.integer  "winner_id"
    t.datetime "played_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["winner_id"], :name => "index_matches_on_winner_id"

  create_table "membership_invitations", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "membership_invitations", ["team_id"], :name => "index_membership_invitations_on_team_id"
  add_index "membership_invitations", ["user_id"], :name => "index_membership_invitations_on_user_id"

  create_table "membership_requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "membership_requests", ["user_id"], :name => "index_membership_requests_on_user_id"
  add_index "membership_requests", ["team_id"], :name => "index_membership_requests_on_team_id"

  create_table "memberships", :force => true do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.boolean  "admin",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["team_id"], :name => "index_memberships_on_team_id"
  add_index "memberships", ["member_id"], :name => "index_memberships_on_member_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metro_areas", :force => true do |t|
    t.string  "name"
    t.integer "state_id"
    t.integer "country_id"
    t.integer "users_count", :default => 0
  end

  create_table "moderatorships", :force => true do |t|
    t.integer "forum_id"
    t.integer "user_id"
  end

  add_index "moderatorships", ["forum_id"], :name => "index_moderatorships_on_forum_id"

  create_table "monitorships", :force => true do |t|
    t.integer "topic_id"
    t.integer "user_id"
    t.boolean "active",   :default => true
  end

  create_table "offerings", :force => true do |t|
    t.integer "skill_id"
    t.integer "user_id"
  end

  create_table "photo_albums", :force => true do |t|
    t.integer  "owner_id"
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.boolean  "public",          :default => true
    t.string   "cached_tag_list"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_albums", ["owner_id", "position"], :name => "index_photo_albums_on_owner_id_and_position", :unique => true

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "width"
    t.integer  "height"
    t.integer  "photo_album_id"
  end

  add_index "photos", ["parent_id"], :name => "index_photos_on_parent_id"
  add_index "photos", ["created_at"], :name => "index_photos_on_created_at"
  add_index "photos", ["photo_album_id"], :name => "index_photos_on_photo_album_id"

  create_table "polls", :force => true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "votes_count", :default => 0
  end

  add_index "polls", ["created_at"], :name => "index_polls_on_created_at"
  add_index "polls", ["post_id"], :name => "index_polls_on_post_id"

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "raw_post"
    t.text     "post"
    t.string   "title"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "view_count",                    :default => 0
    t.integer  "contest_id"
    t.integer  "emailed_count",                 :default => 0
    t.integer  "favorited_count",               :default => 0
    t.string   "published_as",    :limit => 16, :default => "draft"
    t.datetime "published_at"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["published_at"], :name => "index_posts_on_published_at"
  add_index "posts", ["published_as"], :name => "index_posts_on_published_as"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "sb_posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
    t.text     "body_html"
  end

  add_index "sb_posts", ["forum_id", "created_at"], :name => "index_sb_posts_on_forum_id"
  add_index "sb_posts", ["user_id", "created_at"], :name => "index_sb_posts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "sessid"
    t.text     "data"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "sessions", ["sessid"], :name => "index_sessions_on_sessid"

  create_table "skills", :force => true do |t|
    t.string "name"
  end

  create_table "sponsor_ad_stats", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsor_profiles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsor_team_stats", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsor_teams", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsore_ads", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string "name"
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_type"], :name => "index_taggings_on_taggable_type"
  add_index "taggings", ["taggable_id"], :name => "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "teams", :force => true do |t|
    t.string   "name",             :limit => 100
    t.text     "description"
    t.text     "description_html"
    t.integer  "creator_id"
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "thumbnail"
  end

  add_index "teams", ["creator_id"], :name => "index_teams_on_creator_id"

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",           :default => 0
    t.integer  "sticky",         :default => 0
    t.integer  "sb_posts_count", :default => 0
    t.datetime "replied_at"
    t.boolean  "locked",         :default => false
    t.integer  "replied_by"
    t.integer  "last_post_id"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["forum_id", "sticky", "replied_at"], :name => "index_topics_on_sticky_and_replied_at"
  add_index "topics", ["forum_id", "replied_at"], :name => "index_topics_on_forum_id_and_replied_at"

  create_table "tournaments", :force => true do |t|
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "name"
    t.text     "description"
    t.date     "from"
    t.date     "to"
    t.string   "venue"
    t.date     "signup_date"
    t.boolean  "signup_online"
    t.integer  "number_of_players"
    t.text     "rules"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "equipment"
  end

  add_index "tournaments", ["creator_id", "creator_type"], :name => "index_tournaments_on_creator_id_and_creator_type"

  create_table "user_profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "ethnicity"
    t.text     "interests"
    t.text     "gaming_philosophy"
    t.text     "gaming_counsel"
    t.text     "equipment_used"
    t.text     "venues"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.text     "description"
    t.integer  "avatar_id"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.text     "stylesheet"
    t.integer  "view_count",                              :default => 0
    t.boolean  "vendor",                                  :default => false
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "state_id"
    t.integer  "metro_area_id"
    t.string   "login_slug"
    t.boolean  "notify_comments",                         :default => true
    t.boolean  "notify_friend_requests",                  :default => true
    t.boolean  "notify_community_news",                   :default => true
    t.integer  "country_id"
    t.boolean  "featured_writer",                         :default => false
    t.datetime "last_login_at"
    t.string   "zip"
    t.date     "birthday"
    t.string   "gender"
    t.boolean  "profile_public",                          :default => true
    t.integer  "activities_count",                        :default => 0
    t.integer  "sb_posts_count",                          :default => 0
    t.datetime "sb_last_seen_at"
    t.integer  "role_id"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.boolean  "sponsor",                                 :default => false
  end

  add_index "users", ["avatar_id"], :name => "index_users_on_avatar_id"
  add_index "users", ["featured_writer"], :name => "index_users_on_featured_writer"
  add_index "users", ["activated_at"], :name => "index_users_on_activated_at"
  add_index "users", ["vendor"], :name => "index_users_on_vendor"
  add_index "users", ["login_slug"], :name => "index_users_on_login_slug"
  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["profile_id", "profile_type"], :name => "index_users_on_profile_id_and_profile_type"

  create_table "votes", :force => true do |t|
    t.string   "user_id"
    t.integer  "poll_id"
    t.integer  "choice_id"
    t.datetime "created_at"
  end

end
