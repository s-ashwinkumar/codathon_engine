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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150121090958) do

  create_table "challenges", :force => true do |t|
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_test_cases", :force => true do |t|
    t.integer  "question_id"
    t.integer  "points"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "input_file_file_name"
    t.string   "input_file_content_type"
    t.integer  "input_file_file_size"
    t.datetime "input_file_updated_at"
    t.string   "output_file_file_name"
    t.string   "output_file_content_type"
    t.integer  "output_file_file_size"
    t.datetime "output_file_updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "points"
    t.integer  "challenge_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "submissions", :force => true do |t|
    t.boolean  "result"
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "question_test_case_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "solution_file_file_name"
    t.string   "solution_file_content_type"
    t.integer  "solution_file_file_size"
    t.datetime "solution_file_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "full_name"
    t.string   "email"
    t.string   "role"
    t.string   "emp_id"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
