class Version < ApplicationRecord
    belongs_to :ontology
#    has_one  :version_description, :dependent => :destroy
#    has_one :version_feasibility, :dependent => :destroy

    has_many :document

#    has_many :version_schedules, :dependent => :delete_all
#    has_one :version_evaluation, :dependent => :destroy
#    has_one :knowledge_acquisition, :dependent => :destroy
    has_many :competence_issues, :dependent => :delete_all
    #    has_one :version_assessment, :dependent => :destroy
    has_and_belongs_to_many :terms
    validates_presence_of :ontology_id
    validates_presence_of :number

    #deleta todos os termos referente a uma versão
    def self.destroy_all_terms(id)
        terms = Term.find_terms(id)
        for t in terms do
            t.destroy
        end
        if terms.nil?
            true
        else
            false
        end
    end
end
