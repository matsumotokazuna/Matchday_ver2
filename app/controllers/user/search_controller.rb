class User::SearchController < User::Base
    def search
        @search_prefecture = params[:search_prefecture]
        unless params[:min_age] == ""
            @min_age  = params[:min_age]
        else
            @min_age  = 0
        end
        unless params[:max_age] == ""
            @max_age = params[:max_age]
        else
            @max_age = 150
        end
        @search_min_age = Date.today.strftime("%Y%m%d").to_i - @min_age.to_i * 10000
        @search_max_age = Date.today.strftime("%Y%m%d").to_i - @max_age.to_i * 10000
        if current_user.gender_cd == "男性"
            @users = User.where(gender_cd: "女性", disabled_at: nil).search(@search_prefecture, @search_min_age, @search_max_age)
        else
            @users = User.where(gender_cd: "男性", disabled_at: nil).search(@search_prefecture, @search_min_age, @search_max_age)
        end
    end
end
