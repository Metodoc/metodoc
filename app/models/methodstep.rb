class Methodstep < ApplicationRecord
    belongs_to  :methodology
    has_many :doc_type, :dependent => :delete_all
end
