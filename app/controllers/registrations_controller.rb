class RegistrationsController < ApplicationController
  def create

  end

  private
  def user_params
    params.permit(:name, :login_email, :password, :password_confirmation)
  end
end
