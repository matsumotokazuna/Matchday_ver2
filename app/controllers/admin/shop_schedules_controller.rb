class Admin::ShopSchedulesController < Admin::Base
    def index
        @shop = Shop.find(params[:shop_id])
        @shop_schedules = ShopSchedule.where(shop_id: @shop.id)
    end

    def new
        @shop = Shop.find(params[:shop_id]) 
        @shop_schedule = ShopSchedule.new
    end

    def create
        @shop = Shop.find(params[:shop_id])
        @shop_schedule = ShopSchedule.new(shop_schedule_params)
        @shop_schedule.shop_id = @shop.id
        @shop_schedule.save
        redirect_to admin_shop_shop_schedules_path(@shop_schedule.shop_id)
    end

    def edit
        @shop = Shop.find(params[:shop_id])
        @shop_schedule = ShopSchedule.find(params[:id])
    end

    def update
        @shop_schedule = ShopSchedule.find(params[:id])
        @shop_schedule.update(shop_schedule_params)
        redirect_to admin_shop_shop_schedules_path(@shop_schedule.shop_id)
    end

    private
    def shop_schedule_params
        params.require(:shop_schedule).permit(:shop_schedule_date, :shop_schedule_time_cd)
    end
end
