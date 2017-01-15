CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(100), "mail" varchar(50), "login" varchar(30), "password" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "versions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "ontology_id" integer, "number" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "competence_issues" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "version_id" integer, "question" varchar(250), "created_at" datetime, "updated_at" datetime, "artefact_status_id" integer);
CREATE TABLE "term_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(200), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "terms_versions" ("term_id" integer, "version_id" integer);
CREATE TABLE "artefact_models" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(250), "filename" varchar(250), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "user_options" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "artefact_model_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "formality_degrees" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(250), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "artefact_statuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(250), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "papers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "paper" varchar(250), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "ontology_users" (
	`ontology_id`	integer,
	`user_id`	integer,
	`paper_id`	INTEGER
);
CREATE TABLE "functions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "functions_papers" ("function_id" integer, "paper_id" integer);
CREATE TABLE "methodologies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "doc_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "methodstep_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "doc_artefacts" ("answer" text, "document_id" integer, "params_config_type_doc_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "responsables" ("level" integer, "document_id" integer, "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "params_config_type_docs" (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`description`	varchar(255),
	`created_at`	datetime,
	`updated_at`	datetime,
	`text_start`	TEXT
);
CREATE TABLE "ontologies" (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`project_name`	varchar(250),
	`name`	varchar(250),
	`domain`	varchar(250),
	`visible`	boolean DEFAULT 't',
	`created_at`	datetime,
	`updated_at`	datetime,
	`formality_degree_id`	integer,
	`methodology_id`	INTEGER NOT NULL
);
CREATE TABLE "methodsteps" (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	varchar(255),
	`inlifecycle`	boolean DEFAULT 't',
	`methodology_id`	integer,
	`created_at`	datetime,
	`updated_at`	datetime
);
CREATE TABLE "doc_config_especs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "destination" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "activity_shedules" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" varchar(255), "deadline" date, "priority" integer, "user_id" integer, "document_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "doc_type_configs" (
	`answer`	boolean DEFAULT 't',
	`doc_type_id`	integer,
	`params_config_Type_Doc_id`	integer,
	`doc_config_espec_id`	INTEGER,
	`created_at`	datetime,
	`updated_at`	datetime
);
CREATE TABLE "relashions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "term1" integer, "term2" integer, "term3" integer, "version_id" integer, "positionA" varchar(255), "positionB" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "terms" (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`term_type_id`	integer,
	`name`	varchar(200),
	`description`	text,
	`created_at`	datetime,
	`updated_at`	datetime,
	`artefact_status_id`	integer,
	`version_id`	INTEGER
);
CREATE TABLE "questions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "question" varchar(255), "answer_type" integer, "document_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "answers" ("answer" text, "document_id" integer, "question_id" integer, "type_answer_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "type_answers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "documents" (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`doc_type_id`	integer,
	`ontology_id`	integer,
	`version_id`	integer,
	`artefact_status_id`	integer,
	`doc_reference`	INTEGER,
	`created_at`	datetime,
	`updated_at`	datetime
);
CREATE TABLE "integrations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "prefix" varchar(255), "uri" varchar(255), "purpose" varchar(255), "document_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO schema_migrations (version) VALUES
('20100208232049'),
('20100208232525'),
('20100208232830'),
('20100208232902'),
('20100208233402'),
('20100209230434'),
('20100210233145'),
('20100211005724'),
('20100222225753'),
('20100223010113'),
('20100223012926'),
('20100224005215'),
('20100224005348'),
('20100224012148'),
('20100313192528'),
('20100313193441'),
('20100314152601'),
('20100423000018'),
('20100423005607'),
('20100511014434'),
('20100511023639'),
('20100511030429'),
('20100511151424'),
('20100511170429'),
('20100511171728'),
('20100511175429'),
('20100511183252'),
('20100511183359'),
('20100517204822'),
('20100518124023'),
('20100617011611'),
('20150911185008'),
('20150926154307'),
('20150926160310'),
('20150929210605'),
('20150929210742'),
('20150929212935'),
('20150929213904'),
('20150929214136'),
('20150929222000'),
('20150929223653'),
('20150929225155'),
('20151014204622'),
('20151014204802'),
('20160116190147'),
('20160412233054'),
('20160412233236'),
('20160412233514'),
('20160424015114'),
('20170107051246');


