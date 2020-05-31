class Admin::ActionsController < Admin::Base
    def index
        @actions = Action.all.includes(:male_user, :female_user)
    end

    def show
        @action = Action.includes(:male_user, :female_user).find(params[:id])
    end
end
