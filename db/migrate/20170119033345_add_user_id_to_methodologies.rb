class AddUserIdToMethodologies < ActiveRecord::Migration[5.0]
    def change
        add_column :methodologies, :user_id, :integer
    end
end
