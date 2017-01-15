class Term < ApplicationRecord
    belongs_to :term_type
    belongs_to :artefact_status
    belongs_to :version
    validates_presence_of :term_type_id, :artefact_status_id, :version_id
    validates_presence_of :name, :description
    validates_length_of :name, :within => 2..250

    def self.find_terms(id)
        #        Term.find(:all, :conditions =>["version_id=?",id])
        Term.where("version_id = ?", id).all
    end

    def self.find_terms_by_type(id, type)
        #        Term.find(:all, :conditions =>["version_id=? AND terms.term_type_id=?",id,type], :order => 'name')
        Term.where("version_id = ? AND terms.term_type_id = ?", id, type).order("name").all
    end

    def self.load_terms(version_id, term_type_id)
        current_version = Version.find(version_id)
        terms = Term.find_terms_by_type(current_version.id, term_type_id)
        if current_version.number > 1
            #            previous_version_id = Version.find(:first, :conditions=>{:ontology_id=> current_version.ontology_id,
            previous_version_id = Version.where(ontology_id: current_version.ontology_id,
                number: current_version.number - 1).select("id").first
            glossary += Term.find_terms_by_type(previous_version_id, term_type_id)
        end
        terms
    end

    #verifica se o termo jah pertence aa versao
    #def self.has_version?(id, version_id)
    #  if Term.find(:first, :include => 'versions', :conditions =>["terms_versions.version_id=? AND terms.id=?", version_id, id]).nil?
    #    false
    #  else
    #    true
    #  end
    #end

    #def self.copy(old, version_id)
    #  term = Term.new(:term_type_id=> old.term_type_id, :name=> old.name, :description=> old.description)
    #  term.versions << Version.find(version_id)
    #  term
    #end

    def self.general_status(version_id)
        rascunho = ArtefactStatus.find_by_description("Rascunho")
        #        if self.find(:first, :conditions=>["version_id=? AND terms.artefact_status_id=?",version_id, rascunho.id])
        if self.where("version_id = ? AND terms.artefact_status_id = ?", version_id, rascunho.id).first
            rascunho.description
        else
            revisao = ArtefactStatus.find_by_description("Revisão Pendente")
            #            if self.find(:first, :conditions=>["version_id=? AND terms.artefact_status_id=?",version_id, revisao.id])
            if self.where("version_id = ? AND terms.artefact_status_id = ?", version_id, revisao.id).first
                revisao.description
            else
                finalizado = ArtefactStatus.find_by_description("Finalizado")
                #                if self.find(:first, :conditions=>["version_id=? AND terms.artefact_status_id=?",version_id, finalizado.id])
                if self.where("version_id = ? AND terms.artefact_status_id = ?", version_id, finalizado.id).first
                    finalizado.description
                else
                    "Não Criado"
                end
            end
        end
    end

end
