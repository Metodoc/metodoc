class AddDocTypeConfigToDocType < ActiveRecord::Migration[5.0]
    def change
        add_reference :doc_types, :doc_type_config, foreign_key: true
    end
end
