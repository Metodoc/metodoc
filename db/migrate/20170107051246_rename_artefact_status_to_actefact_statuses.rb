class RenameArtefactStatusToActefactStatuses < ActiveRecord::Migration[5.0]
    def self.up
        rename_table :artefact_status, :artefact_statuses
    end
end
