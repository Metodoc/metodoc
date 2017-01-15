class DocType < ApplicationRecord
#    attr_accessor :name, :methodstep_id
    has_many :doc_type_config, :dependent => :delete_all
    has_many :document

    belongs_to :methodstep
end
