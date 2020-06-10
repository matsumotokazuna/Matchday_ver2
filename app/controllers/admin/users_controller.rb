class Admin::UsersController < Admin::Base
    before_action :authenticate_admin!
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to admin_user_path(@user.id)
    end

    private
    def user_params
        params.require(:user).permit(
            :user_image,
            :name,
            :email,
            :birth_date,
            :prefecture_cd,
            :job_cd,
            :height_cd,
            :income_cd,
            :marriage_history_cd,
            :marriage_purpose_cd,
            :housemate_cd,
            :holiday_cd,
            :alcohol_cd,
            :cigaret_cd,
            :introduction,
            :disabled_at
        )
    end
end
