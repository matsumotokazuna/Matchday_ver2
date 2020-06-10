class User::ActivitiesController < User::Base
    def from_partner
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activities = Activity.where(male_matching_at: nil, male_user_id: current_user.id).includes(:female_user)
        else #ログインユーザが女性の場合
            @activities = Activity.where(female_matching_at: nil, female_user_id: current_user.id).includes(:male_user)  
        end
    end

    def from_me
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activities = Activity.where(female_matching_at: nil, male_user_id: current_user.id).includes(:female_user)
        else #ログインユーザが女性の場合
            @activities = Activity.where(male_matching_at: nil, female_user_id: current_user.id).includes(:male_user)
        end
    end

    def date
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activities = Activity.where.not(matching_at: nil).where(male_user_id: current_user.id).includes(:female_user, :shop)
        else #ログインユーザが女性の場合
            @activities = Activity.where.not(matching_at: nil).where(female_user_id: current_user.id).includes(:male_user, :shop)
        end
    end

    def show
        @user = User.find(params[:partner_user_id]) #相手の情報
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activity = Activity.includes(:male_user, :female_user, :shop).find_by(male_user_id: current_user.id, female_user_id: @user.id)
            @male_schedules = UserSchedule.where(user_id: current_user.id)
            @female_schedules = UserSchedule.where(user_id: @user.id)
        else #ログインユーザが女性の場合
            @activity = Activity.includes(:male_user, :female_user, :shop).find_by(male_user_id: @user.id, female_user_id: current_user.id)
            @male_schedules = UserSchedule.where(user_id: @user.id)
            @female_schedules = UserSchedule.where(user_id: current_user.id)
        end
        if @male_schedules == [] or @female_schedules == []
            @schedule_date = nil
        else
        roop_end = false
        @male_schedules.each do |male_schedule|
        @female_schedules.each do |female_schedule|
            if male_schedule.user_schedule_date == female_schedule.user_schedule_date && male_schedule.user_schedule_time_cd == female_schedule.user_schedule_time_cd
                @schedule_date = male_schedule.user_schedule_date
                @schedule_time = male_schedule.user_schedule_time_cd
            roop_end = true
            break
            end
        end
        break if roop_end
        end
        end
        # 合致している店舗の予定を確認
        @shops = ShopSchedule.where(shop_schedule_date: @schedule_date, shop_schedule_time_cd: @schedule_time)
    end

    def update
        @activity = Activity.find(params[:id])
        @male_schedules = UserSchedule.where(user_id: @activity.male_user_id)
        @female_schedules = UserSchedule.where(user_id: @activity.female_user_id)
        roop_end = false
        @male_schedules.each do |male_schedule|
            @female_schedules.each do |female_schedule|
                if male_schedule.user_schedule_date == female_schedule.user_schedule_date && male_schedule.user_schedule_time_cd == female_schedule.user_schedule_time_cd
                    @activity.matching_date = male_schedule.user_schedule_date
                    @activity.matching_time_cd = male_schedule.user_schedule_time_cd
                roop_end = true
                break
                end
            end
            break if roop_end
        end
        @activity.update(activity_params)
        # デートが登録されたら、男性と女性のスケジュールから該当のスケジュールを削除する
        @male_schedule = UserSchedule.find_by(user_id: @activity.male_user_id, user_schedule_date: @activity.matching_date, user_schedule_time_cd: @activity.matching_time_cd)
        @female_schedule = UserSchedule.find_by(user_id: @activity.female_user_id, user_schedule_date: @activity.matching_date, user_schedule_time_cd: @activity.matching_time_cd)
        @male_schedule.destroy
        @female_schedule.destroy
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合 
            redirect_to show_activities_path(@activity.female_user_id)
        else #ログインユーザが女性の場合
            redirect_to show_activities_path(@activity.male_user_id)
        end   
    end

    def edit
        @user = User.find(params[:partner_user_id]) #相手の情報
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @activity = Activity.includes(:male_user, :female_user, :shop).find_by(male_user_id: current_user.id, female_user_id: @user.id)
            if @activity.matching_date == Date.today
                redirect_back(fallback_location: root_path)
            else
            end
        else #ログインユーザが女性の場合
            @activity = Activity.includes(:male_user, :female_user, :shop).find_by(male_user_id: @user.id, female_user_id: current_user.id)
            if  @activity.matching_date == Date.today
                redirect_back(fallback_location: root_path)
            else
            end
        end
        @shops = ShopSchedule.where(shop_schedule_date: @activity.matching_date, shop_schedule_time_cd: @activity.matching_time_cd)
    end

    def destroy
        @activity = Activity.find(params[:id])
        @activity.destroy
        redirect_to activities_date_path
    end

    private
    def activity_params
        params.require(:activity).permit(:shop_id)
    end
end
