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

ActiveRecord::Schema.define(version: 2020_05_02_184648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "combs", force: :cascade do |t|
    t.integer "sweet_spot", null: false
    t.integer "bee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bee_id"], name: "index_combs_on_bee_id"
  end

  create_table "pollen_collections", force: :cascade do |t|
    t.integer "bee_id", null: false
    t.integer "comb_id", null: false
    t.integer "nectar_consumption", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pollen_glob_collected"
    t.integer "#<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition"
    t.integer "advisement"
    t.string "advisement_accepted"
    t.index ["bee_id"], name: "index_pollen_collections_on_bee_id"
    t.index ["comb_id"], name: "index_pollen_collections_on_comb_id"
    t.index ["pollen_glob_collected"], name: "index_pollen_collections_on_pollen_glob_collected"
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
    t.integer "nectar"
    t.string "bee_name"
    t.integer "comb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nectar"], name: "index_worker_bees_on_nectar"
  end

end
