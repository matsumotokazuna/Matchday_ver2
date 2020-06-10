class User::UsersController < User::Base
    def index
        @user = current_user
        if @user.gender_cd == "男性"
            @users = User.where(gender_cd: "女性") 
        elsif @usgiter.gender_cd == "女性"
            @users = User.where(gender_cd: "男性")
        else
        end
    end

    def show
        @user = User.find(params[:id])
        if current_user.gender_cd == "男性" && @user.gender_cd == "男性"
            redirect_back(fallback_location: root_path)
        elsif current_user.gender_cd == "女性" && @user.gender_cd == "女性" 
            redirect_back(fallback_location: root_path)
        else
            if current_user.gender_cd == "男性" #ログインユーザが男性の場合
                @activity = Activity.includes(:male_user, :female_user).find_by(male_user_id: current_user.id, female_user_id: @user.id)
            else #ログインユーザが女性の場合
                @activity = Activity.includes(:male_user, :female_user).find_by(male_user_id: @user.id, female_user_id: current_user.id)
            end
        end
    end

    def create_activity
        @user = User.find(params[:id])
        @activity = Activity.new
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activity.male_user_id = current_user.id
            @activity.female_user_id = @user.id
            @activity.male_matching_at = DateTime.now
        else #ログインユーザが女性の場合
            @activity.male_user_id = @user.id
            @activity.female_user_id = current_user.id
            @activity.female_matching_at = DateTime.now
        end
        @activity.save
        redirect_to user_path(@user.id)
    end

    def update_activity
        @user = User.find(params[:id])
        if  current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activity = Activity.find_by(male_user_id: current_user.id, female_user_id: @user.id)
            @activity.male_matching_at = DateTime.now
            @activity.matching_at = DateTime.now
        else #ログインユーザが女性の場合
            @activity = Activity.find_by(male_user_id: @user.id, female_user_id: current_user.id)
            @activity.female_matching_at = DateTime.now
            @activity.matching_at = DateTime.now
        end
        @activity.save
        redirect_to user_path(@user.id)
    end
end
