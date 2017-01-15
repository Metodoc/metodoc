class Answer < ApplicationRecord
    belongs_to :document
    belongs_to :question
    belongs_to :type_answer
end
