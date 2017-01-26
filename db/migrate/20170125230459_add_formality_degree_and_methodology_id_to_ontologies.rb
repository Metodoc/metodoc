class AddFormalityDegreeAndMethodologyIdToOntologies < ActiveRecord::Migration[5.0]
    def change
        add_reference :ontologies, :formality_degree, foreign_key: true
        add_reference :ontologies, :methodology, foreign_key: true
    end
end
