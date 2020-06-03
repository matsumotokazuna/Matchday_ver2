class Admin::UserSchedulesController < Admin::Base
    def index
        @user = User.find(params[:user_id])
        @user_schedules = UserSchedule.where(user_id: @user.id)
    end
end
