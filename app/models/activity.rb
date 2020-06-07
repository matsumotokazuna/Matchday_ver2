class Activity < ApplicationRecord
    belongs_to :user, foreign_key: "male_user_id"
    belongs_to :user, foreign_key: "female_user_id"

    belongs_to :male_user, :class_name => 'User', :foreign_key => 'male_user_id'  
    belongs_to :female_user, :class_name => 'User', :foreign_key => 'female_user_id' 

    belongs_to :shop, optional: true
    
    enum matching_time_cd: {
        "10:00〜12:00":1,"12:00〜14:00":2,"14:00〜16:00":3,
        "16:00〜18:00":4,"18:00〜20:00":5,"20:00〜22:00":6
    }
end
