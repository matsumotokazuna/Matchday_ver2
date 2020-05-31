class User::ActionsController < User::Base
    def from_partner
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @actions = Action.where(male_matching_at: nil, male_user_id: current_user.id).includes(:female_user)
        else #ログインユーザが女性の場合
            @actions = Action.where(female_matching_at: nil, female_user_id: current_user.id).includes(:male_user)  
        end
    end

    def from_me
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @actions = Action.where(female_matching_at: nil, male_user_id: current_user.id).includes(:female_user)
        else #ログインユーザが女性の場合
            @actions = Action.where(male_matching_at: nil, female_user_id: current_user.id).includes(:male_user)
        end
    end
end
