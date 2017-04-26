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

  create_table "activity_shedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.date     "deadline"
    t.integer  "priority"
    t.integer  "user_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "answer",         limit: 65535
    t.integer  "document_id"
    t.integer  "question_id"
    t.integer  "type_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artefact_models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 250
    t.string   "filename",   limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artefact_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description", limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competence_issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.string   "question",           limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "doc_artefacts", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "answer",                    limit: 65535
    t.integer  "document_id"
    t.integer  "params_config_type_doc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_config_especs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_type_configs", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "answer",                    default: true
    t.integer  "doc_type_id"
    t.integer  "params_config_Type_Doc_id"
    t.integer  "doc_config_espec_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "methodstep_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doc_type_config_id"
    t.index ["doc_type_config_id"], name: "index_doc_types_on_doc_type_config_id", using: :btree
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "doc_reference"
    t.integer  "doc_type_id"
    t.integer  "ontology_id"
    t.integer  "version_id"
    t.integer  "artefact_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formality_degrees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions_papers", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "function_id"
    t.integer "paper_id"
  end

  create_table "integrations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "prefix"
    t.string   "uri"
    t.string   "purpose"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knowledge_acquisitions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.text     "sources",            limit: 65535
    t.text     "strategies",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "letsencrypt_plugin_challenges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "response",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "letsencrypt_plugin_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "private_key", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "methodologies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "methodsteps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "inlifecycle",    default: true
    t.integer  "methodology_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontologies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "project_name", limit: 250
    t.string   "name",         limit: 250
    t.string   "domain",       limit: 250
    t.boolean  "visible",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontology_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ontology_id"
    t.integer "user_id"
    t.integer "paper_id"
  end

  create_table "papers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "paper",      limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "params_config_type_docs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description"
    t.text     "text_start",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_descriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "ontology_id"
    t.datetime "date"
    t.text     "purpose",            limit: 65535
    t.text     "obs",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "project_feasibilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "ontology_id"
    t.text     "opportunities",      limit: 65535
    t.text     "problems",           limit: 65535
    t.text     "solutions",          limit: 65535
    t.text     "features",           limit: 65535
    t.text     "conclusion",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "question"
    t.integer  "answer_type"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relashions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "term1"
    t.integer  "term2"
    t.integer  "term3"
    t.integer  "version_id"
    t.string   "positionA"
    t.string   "positionB"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responsables", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "level"
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description", limit: 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "term_type_id"
    t.integer  "version_id"
    t.string   "name",               limit: 200
    t.text     "description",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "terms_versions", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "term_id"
    t.integer "version_id"
  end

  create_table "type_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "artefact_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "version_assessments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.integer  "artefact_status_id"
    t.text     "technical_assessment", limit: 65535
    t.text     "user_assessment",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "version_descriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.datetime "date"
    t.string   "responsible",        limit: 250
    t.text     "purpose",            limit: 65535
    t.text     "obs",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "version_evaluations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.text     "quality_criteria",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "version_feasibilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.string   "responsible",        limit: 250
    t.text     "opportunities",      limit: 65535
    t.text     "problems",           limit: 65535
    t.text     "solutions",          limit: 65535
    t.text     "features",           limit: 65535
    t.text     "conclusion",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "version_schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "version_id"
    t.string   "activity_name"
    t.text     "activity_description", limit: 65535
    t.datetime "activity_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artefact_status_id"
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "ontology_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
