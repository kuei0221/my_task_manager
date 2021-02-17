# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_17_135557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "start"
    t.datetime "end"
    t.string "status", default: "pending"
    t.string "priority", default: "low"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end"], name: "index_tasks_on_end"
    t.index ["name"], name: "index_tasks_on_name"
    t.index ["priority"], name: "index_tasks_on_priority"
    t.index ["start"], name: "index_tasks_on_start"
    t.index ["status"], name: "index_tasks_on_status"
  end

end
