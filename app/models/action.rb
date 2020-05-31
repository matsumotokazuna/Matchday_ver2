class Action < ApplicationRecord
    belongs_to :user, foreign_key: "male_user_id"
    belongs_to :user, foreign_key: "female_user_id"

    belongs_to :male_user, :class_name => 'User', :foreign_key => 'male_user_id'  
    belongs_to :female_user, :class_name => 'User', :foreign_key => 'female_user_id'  
end
