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

ActiveRecord::Schema.define(version: 2020_04_30_174957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "combs", force: :cascade do |t|
    t.integer "nectar_volume"
    t.integer "bee_id"
    t.integer "supervisor_bee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bee_id"], name: "index_combs_on_bee_id"
    t.index ["nectar_volume"], name: "index_combs_on_nectar_volume"
    t.index ["supervisor_bee_id"], name: "index_combs_on_supervisor_bee_id"
  end

  create_table "supervisor_bees", force: :cascade do |t|
    t.integer "bee_id", null: false
    t.integer "comb_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bee_id"], name: "index_supervisor_bees_on_bee_id"
    t.index ["comb_id"], name: "index_supervisor_bees_on_comb_id"
  end

  create_table "worker_bees", force: :cascade do |t|
    t.integer "pollen_globs"
    t.integer "nectar"
    t.string "bee_name"
    t.integer "comb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nectar"], name: "index_worker_bees_on_nectar"
    t.index ["pollen_globs"], name: "index_worker_bees_on_pollen_globs"
  end

end
