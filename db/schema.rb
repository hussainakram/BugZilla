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

ActiveRecord::Schema.define(version: 20180427115354) do

  create_table "audits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bug_id"
    t.string   "changed_attribute"
    t.string   "action_performed"
    t.integer  "version"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "previous_value"
    t.string   "new_value"
    t.index ["bug_id"], name: "index_audits_on_bug_id"
    t.index ["user_id"], name: "index_audits_on_user_id"
  end

  create_table "bugs", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.date     "deadline"
    t.string   "bug_type",    null: false
    t.string   "status",      null: false
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
    t.string   "post_id"
    t.integer  "assign_to"
    t.integer  "sprint_id"
    t.index ["project_id"], name: "index_bugs_on_project_id"
    t.index ["sprint_id"], name: "index_bugs_on_sprint_id"
    t.index ["title"], name: "index_bugs_on_title", unique: true
    t.index ["user_id"], name: "index_bugs_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["name"], name: "index_projects_on_name", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["project_id"], name: "index_sprints_on_project_id"
    t.index ["user_id"], name: "index_sprints_on_user_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "user_type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
