class User::ActionsController < User::Base
    def create
        @action = Action.new(action_params)
        @action.save
    end

    def update
        @action = Action.find(params[:id])
        @action.update(action_params)
    end

    private
    def action_params
        params.require(:action).permit(
            :male_user_id,
            :female_user_id,
            :male_matching_at,
            :female_matching_at,
            :matching_at
        )
    end
end
