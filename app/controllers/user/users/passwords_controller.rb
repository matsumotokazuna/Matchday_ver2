# frozen_string_literal: true

class User::Users::PasswordsController < Devise::PasswordsController
  layout 'user'
  prepend_before_action :require_no_authentication, only: :new
  append_before_action :assert_reset_token_passed, only: :no_link

  # メールリンクなしで:new,:create,:edit,:updateできるようにする
  def no_link
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
    def update
      current_user.reset_password( params[:user][:password], params[:user][:password])
      redirect_to root_path
    end


  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
