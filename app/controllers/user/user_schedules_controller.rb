class User::UserSchedulesController < User::Base
    def index
        @user_schedules = UserSchedule.where(user_id: current_user.id)
    end

    def new
        @user_schedule = UserSchedule.new
    end

    def create
        @user_schedule = UserSchedule.new(user_schedule_params) 
        @user_schedule.user_id = current_user.id   
        @user_schedule.save
        redirect_to user_schedules_path
    end

    def edit
        @shop_schedule = UserSchedule.find(params[:id])
    end

    def update
        @shop_schedule = UserSchedule.find(params[:id])
        @shop_schedule.update(user_schedule_params)
        redirect_to user_schedules_path
    end

    private
    def user_schedule_params
        params.require(:user_schedule).permit(:user_schedule_date, :user_schedule_time_cd)
    end
end
