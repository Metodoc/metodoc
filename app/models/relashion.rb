class Relashion < ApplicationRecord
    has_one :term, :through => :term1, :term2, :term3 
end
