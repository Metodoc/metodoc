class Methodology < ApplicationRecord
    has_many :methodstep, :dependent => :delete_all
    has_many :ontology, :dependent => :delete_all
end
