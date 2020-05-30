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
            @action_exist_check = Action.find_by(male_user_id: current_user.id, female_user_id: @user.id)
            if @action_exist_check == nil #actionが未作成の場合
                @action = Action.new
            else #actionが既に存在する場合
                @action = @action_exist_check
            end
        else #ログインユーザが女性の場合
            @action_exist_check = Action.find_by(male_user_id: @user.id, female_user_id: current_user.id)
            if @action_exist_check == nil #actionが未作成の場合
                @action = Action.new
            else #actionが既に存在する場合
                @action = @action_exist_check
            end
        end
    end

end
