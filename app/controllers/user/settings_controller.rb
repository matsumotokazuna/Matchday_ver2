class User::SettingsController < User::Base
    def index
        @user = current_user
    end

    def settings_profile
        @user = current_user
    end

    def update_profile
        @user = current_user
        @user.update(user_params)
        redirect_to settings_path
    end

    def settings_email
        @user = current_user
    end

    def update_email
        @user = current_user
        @user.update(email_params)
        redirect_to settings_path
    end

    def settings_withdraw
        @user = current_user
    end

    def update_withdraw
        @user = current_user
        @user.disabled_at = DateTime.now
        @user.email = @user.disabled_at.strftime('%Y-%m-%d').to_s + '_' + @user.email.to_s
        @user.save
        session[:user] = nil
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(
            :user_image,
            :name,
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
            :introduction
        )
    end

    def email_params
        params.require(:user).permit(:email)
    end

end
