class User::UserSchedulesController < User::Base
    before_action :authenticate_user!
    def index
        @user_schedules = UserSchedule.where(user_id: current_user.id)
        @user_schedules_json = @user_schedules.to_json.html_safe
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
        @user_schedule = UserSchedule.find(params[:id])
    end

    def update
        @user_schedule = UserSchedule.find(params[:id])
        @user_schedule.update(user_schedule_params)
        redirect_to user_schedules_path
    end

    def destroy
        @user_schedule = UserSchedule.find(params[:id])
        @user_schedule.destroy
        redirect_to user_schedules_path
    end

    private
    def user_schedule_params
        params.require(:user_schedule).permit(:user_schedule_date, :user_schedule_time_cd)
    end
end
