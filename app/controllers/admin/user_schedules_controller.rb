class Admin::UserSchedulesController < Admin::Base
    before_action :authenticate_admin!
    def index
        @user = User.find(params[:user_id])
        @user_schedules = UserSchedule.where(user_id: @user.id)
    end
end
