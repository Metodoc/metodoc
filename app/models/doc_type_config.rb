class DocTypeConfig < ApplicationRecord
    belongs_to :doc_type
    belongs_to :params_config_Type_Doc
    belongs_to :doc_config_espec, optional: true


    def self.delete1(doc_type_id, params_config_Type_Doc_id)
        DocTypeConfig.find_by_sql(['delete from doc_type_configs where doc_type_id = ? and params_config_Type_Doc_id = ?', doc_type_id, params_config_Type_Doc_id ])
    end
    def self.delete2(doc_type_id)
        DocTypeConfig.find_by_sql(['delete from doc_type_configs where doc_type_id = ?', doc_type_id])
    end 
end
