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

ActiveRecord::Schema.define(version: 20170119033345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_shedules", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.date     "deadline"
    t.integer  "priority"
    t.integer  "user_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", id: false, force: :cascade do |t|
    t.text     "answer"
    t.integer  "document_id"
    t.integer  "question_id"
    t.integer  "type_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artefact_models", force: :cascade do |t|
    t.string   "name",       limit: 250
    t.string   "filename",   limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artefact_statuses", force: :cascade do |t|
    t.string   "description", limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competence_issues", force: :cascade do |t|
    t.integer  "version_id"
    t.string   "question",           limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "doc_artefacts", id: false, force: :cascade do |t|
    t.text     "answer"
    t.integer  "document_id"
    t.integer  "params_config_type_doc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_config_especs", force: :cascade do |t|
    t.string   "name"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_type_configs", id: false, force: :cascade do |t|
    t.boolean  "answer",                    default: true
    t.integer  "doc_type_id"
    t.integer  "params_config_Type_Doc_id"
    t.integer  "doc_config_espec_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "methodstep_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "doc_reference"
    t.integer  "doc_type_id"
    t.integer  "ontology_id"
    t.integer  "version_id"
    t.integer  "artefact_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formality_degrees", force: :cascade do |t|
    t.string   "name",       limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions_papers", id: false, force: :cascade do |t|
    t.integer "function_id"
    t.integer "paper_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.string   "name"
    t.string   "prefix"
    t.string   "uri"
    t.string   "purpose"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledge_acquisitions", force: :cascade do |t|
    t.integer  "version_id"
    t.text     "sources"
    t.text     "strategies"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "letsencrypt_plugin_challenges", force: :cascade do |t|
    t.text     "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "letsencrypt_plugin_settings", force: :cascade do |t|
    t.text     "private_key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "methodologies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "methodsteps", force: :cascade do |t|
    t.string   "name"
    t.boolean  "inlifecycle",    default: true
    t.integer  "methodology_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontologies", force: :cascade do |t|
    t.string   "project_name",        limit: 250
    t.string   "name",                limit: 250
    t.string   "domain",              limit: 250
    t.boolean  "visible",                         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "formality_degree_id"
  end

  create_table "ontology_users", id: false, force: :cascade do |t|
    t.integer "ontology_id"
    t.integer "user_id"
    t.integer "paper_id"
  end

  create_table "papers", force: :cascade do |t|
    t.string   "paper",      limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "params_config_type_docs", force: :cascade do |t|
    t.string   "description"
    t.text     "text_start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_descriptions", force: :cascade do |t|
    t.integer  "ontology_id"
    t.datetime "date"
    t.text     "purpose"
    t.text     "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "project_feasibilities", force: :cascade do |t|
    t.integer  "ontology_id"
    t.text     "opportunities"
    t.text     "problems"
    t.text     "solutions"
    t.text     "features"
    t.text     "conclusion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "answer_type"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relashions", force: :cascade do |t|
    t.integer  "term1"
    t.integer  "term2"
    t.integer  "term3"
    t.integer  "version_id"
    t.string   "positionA"
    t.string   "positionB"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responsables", id: false, force: :cascade do |t|
    t.integer  "level"
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_types", force: :cascade do |t|
    t.string   "description", limit: 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: :cascade do |t|
    t.integer  "term_type_id"
    t.integer  "version_id"
    t.string   "name",               limit: 200
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "terms_versions", id: false, force: :cascade do |t|
    t.integer "term_id"
    t.integer "version_id"
  end

  create_table "type_answers", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_options", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "artefact_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "version_assessments", force: :cascade do |t|
    t.integer  "version_id"
    t.integer  "artefact_status_id"
    t.text     "technical_assessment"
    t.text     "user_assessment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "version_descriptions", force: :cascade do |t|
    t.integer  "version_id"
    t.datetime "date"
    t.string   "responsible",        limit: 250
    t.text     "purpose"
    t.text     "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "version_evaluations", force: :cascade do |t|
    t.integer  "version_id"
    t.text     "quality_criteria"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "version_feasibilities", force: :cascade do |t|
    t.integer  "version_id"
    t.string   "responsible",        limit: 250
    t.text     "opportunities"
    t.text     "problems"
    t.text     "solutions"
    t.text     "features"
    t.text     "conclusion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "version_schedules", force: :cascade do |t|
    t.integer  "version_id"
    t.string   "activity_name"
    t.text     "activity_description"
    t.datetime "activity_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "versions", force: :cascade do |t|
    t.integer  "ontology_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
