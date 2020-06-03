class Admin::ActionsController < Admin::Base
    def index
        @actions = Action.all.includes(:male_user, :female_user)
    end

    def show
        @action = Action.includes(:male_user, :female_user, :shop).find(params[:id])
    end

    def edit
        @shops = Shop.all
        @action = Action.includes(:male_user, :female_user, :shop).find(params[:id])
    end

    def update
        @action = Action.find(params[:id])
        @action.update(action_params)
        redirect_to admin_action_path(@action.id)
    end

    def destroy
        @action = Action.find(params[:id])
        @action.destroy
        redirect_to admin_actions_path
    end

    private
    def action_params
        params.require(:action).permit(:shop_id)
    end
end
