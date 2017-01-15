class ActivityShedule < ApplicationRecord
    belongs_to :document
    belongs_to :user

    validates_presence_of :name
    validates_presence_of :user_id
    validates_presence_of :document_id
end
