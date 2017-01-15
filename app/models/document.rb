class Document < ApplicationRecord
    belongs_to :doc_type
    belongs_to :ontology
    belongs_to :version
    belongs_to :artefact_status

    has_many :doc_artefact
    has_many :responsable
    has_many :questions, :dependent => :delete_all
    has_many :answer, :dependent => :delete_all
    has_many :activity_shedule
    has_many :integration
end
