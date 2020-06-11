class Admin::ActivitiesController < Admin::Base
    before_action :authenticate_admin!
    def index
        @activities = Activity.all.includes(:male_user, :female_user)
    end

    def show
        @activity = Activity.includes(:male_user, :female_user, :shop).find(params[:id])
    end

    def edit
        @shops = Shop.all
        @activity = Activity.includes(:male_user, :female_user, :shop).find(params[:id])
    end

    def update
        @activity = Activity.find(params[:id])
        @activity.update(activity_params)
        redirect_to admin_action_path(@action.id)
    end

    def destroy
        @action = Activity.find(params[:id])
        @action.destroy
        redirect_to admin_activities_path
    end

    private
    def activity_params
        params.require(:activity).permit(:shop_id)
    end
end
