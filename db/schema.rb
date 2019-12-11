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

ActiveRecord::Schema.define(version: 20181120110457) do
  create_table 'asset_missions', force: :cascade do |t|
    t.integer 'measurement_interval'
    t.integer 'measurement_duration'
    t.text 'placement_indications'
    t.boolean 'battery_replaced'
    t.integer 'user_id'
    t.integer 'mission_id'
    t.integer 'asset_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'extracted_at'
    t.index ['asset_id'], name: 'index_asset_missions_on_asset_id'
    t.index ['mission_id'], name: 'index_asset_missions_on_mission_id'
    t.index ['user_id'], name: 'index_asset_missions_on_user_id'
  end

  create_table 'asset_types', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'assets', force: :cascade do |t|
    t.text 'description'
    t.text 'product_serial'
    t.integer 'battery_life'
    t.integer 'user_id'
    t.datetime 'date_purchase'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'asset_type_id'
    t.index ['asset_type_id'], name: 'index_assets_on_asset_type_id'
    t.index ['user_id'], name: 'index_assets_on_user_id'
  end

  create_table 'battery_replacements', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'asset_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['asset_id'], name: 'index_battery_replacements_on_asset_id'
    t.index ['user_id'], name: 'index_battery_replacements_on_user_id'
  end

  create_table 'missions', force: :cascade do |t|
    t.string 'project_name'
    t.text 'description'
    t.datetime 'starting_date'
    t.datetime 'ending_date'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_missions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'firstname'
    t.string 'lastname'
    t.string 'mail'
    t.string 'password'
    t.string 'token'
    t.string 'salt'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
