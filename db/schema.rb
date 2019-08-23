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

ActiveRecord::Schema.define(version: 2019_08_22_020537) do

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "subject"
    t.integer "student_id"
    t.integer "professor_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.string "colors"
    t.string "values"
    t.string "mascot"
    t.string "house_ghost"
    t.string "founder"
  end

  create_table "professors", force: :cascade do |t|
    t.string "name"
    t.boolean "order_of_the_phoenix"
    t.boolean "dumbledores_army"
    t.string "specialty"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.boolean "dumbledores_army"
    t.boolean "order_of_the_phoenix"
    t.integer "house_id"
  end

end
