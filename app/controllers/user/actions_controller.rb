class User::ActionsController < User::Base
    def from_partner
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @actions = Action.where(male_matching_at: nil, male_user_id: current_user.id).includes(:female_user)
        else #ログインユーザが女性の場合
            @actions = Action.where(female_matching_at: nil, female_user_id: current_user.id).includes(:male_user)  
        end
    end

    def from_me
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @actions = Action.where(female_matching_at: nil, male_user_id: current_user.id).includes(:female_user)
        else #ログインユーザが女性の場合
            @actions = Action.where(male_matching_at: nil, female_user_id: current_user.id).includes(:male_user)
        end
    end

    def date
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @actions = Action.where.not(matching_at: nil).where(male_user_id: current_user.id).includes(:female_user, :shop)
        else #ログインユーザが女性の場合
            @actions = Action.where.not(matching_at: nil).where(female_user_id: current_user.id).includes(:male_user, :shop)
        end
    end

    def show
        @user = User.find(params[:partner_user_id]) #相手の情報
        @shops = Shop.all
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @action = Action.includes(:male_user, :female_user, :shop).find_by(male_user_id: current_user.id, female_user_id: @user.id)
            @male_schedules = UserSchedule.where(user_id: current_user.id)
            @female_schedules = UserSchedule.where(user_id: @user.id)
        else #ログインユーザが女性の場合
            @action = Action.includes(:male_user, :female_user, :shop).find_by(male_user_id: @user.id, female_user_id: current_user.id)
            @male_schedules = UserSchedule.where(user_id: @user.id)
            @female_schedules = UserSchedule.where(user_id: current_user.id)
        end
    end

    def update
        @action = Action.find(params[:id])
            @male_schedules = UserSchedule.where(user_id: @action.male_user_id)
            @female_schedules = UserSchedule.where(user_id: @action.female_user_id)
            @male_schedules.each do |male_schedule|
                @female_schedules.each do |female_schedule|
                    if male_schedule.user_schedule_date == female_schedule.user_schedule_date && male_schedule.user_schedule_time_cd == female_schedule.user_schedule_time_cd
                        @action.matching_date = male_schedule.user_schedule_date
                        @action.matching_time_cd = male_schedule.user_schedule_time_cd
                    end
                end
            end
        @action.update(action_params)
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合 
            redirect_to show_action_path(@action.female_user_id)
        else #ログインユーザが女性の場合
            redirect_to show_action_path(@action.male_user_id)
        end   
    end

    def edit
        @user = User.find(params[:partner_user_id]) #相手の情報
        @shops = Shop.all
        if current_user.gender_cd == "男性" #ログインユーザが男性の場合
            @action = Action.includes(:male_user, :female_user, :shop).find_by(male_user_id: current_user.id, female_user_id: @user.id)
            if @action.matching_date == Date.today
                redirect_back(fallback_location: root_path)
            else
            end
        else #ログインユーザが女性の場合
            @action = Action.includes(:male_user, :female_user, :shop).find_by(male_user_id: @user.id, female_user_id: current_user.id)
            if  @action.matching_date == Date.today
                redirect_back(fallback_location: root_path)
            else
            end
        end
    end

    def destroy
        @action = Action.find(params[:id])
        @action.destroy
        redirect_to actions_date_path
    end

    private
    def action_params
        params.require(:action).permit(:shop_id)
    end
end
