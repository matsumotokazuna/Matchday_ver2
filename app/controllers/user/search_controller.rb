class User::SearchController < User::Base
    before_action :authenticate_user!
    def search
        @search_prefecture = params[:search_prefecture]
        unless params[:min_age] == ""
            @search_min_age  = params[:min_age]
        else
            @search_min_age  = 0
        end
        unless params[:max_age] == ""
            @search_max_age = params[:max_age]
        else
            @search_max_age = 150
        end
        if current_user.gender_cd == "男性"
            @users = User.where(gender_cd: "女性", disabled_at: nil).search(@search_prefecture, @search_min_age, @search_max_age)
        else
            @users = User.where(gender_cd: "男性", disabled_at: nil).search(@search_prefecture, @search_min_age, @search_max_age)
        end
    end
end
