class User::UsersController < User::Base
    def index
        @user = current_user
        if @user.gender_cd == "男性"
            @users = User.where(gender_cd: "女性")
        elsif @user.gender_cd == "女性"
            @users = User.where(gender_cd: "男性")
        else
        end
    end

    def show
        @user = User.find(params[:id])
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @action = Action.find_by(male_user_id: current_user.id, female_user_id: @user.id)
        else #ログインユーザが女性の場合
            @action = Action.find_by(male_user_id: @user.id, female_user_id: current_user.id)
        end
    end

    def create_action
        @user = User.find(params[:id])
        @action = Action.new
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @action.male_user_id = current_user.id
            @action.female_user_id = @user.id
            @action.male_matching_at = DateTime.now
        else #ログインユーザが女性の場合
            @action.male_user_id = @user.id
            @action.female_user_id = current_user.id
            @action.female_matching_at = DateTime.now
        end
        @action.save
        redirect_to user_path(@user.id)
    end

    def update_action
        @user = User.find(params[:id])
        if  current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @action = Action.find_by(male_user_id: current_user.id, female_user_id: @user.id)
            @action.male_matching_at = DateTime.now
            @action.matching_at = DateTime.now
        else #ログインユーザが女性の場合
            @action = Action.find_by(male_user_id: @user.id, female_user_id: current_user.id)
            @action.female_matching_at = DateTime.now
            @action.matching_at = DateTime.now
        end
        @action.save
        redirect_to user_path(@user.id)
    end
end
