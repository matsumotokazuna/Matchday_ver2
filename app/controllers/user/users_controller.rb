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
    end
end
