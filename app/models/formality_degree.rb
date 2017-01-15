class FormalityDegree < ApplicationRecord
    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :ontologies
end
