class ResetPasswordController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email].downcase)
    if @user
      @user.password_reset()
      redirect_to root_path, notice: "Email sent with password reset instructions."
    else
      redirect_to root_path, alert: "Invalid email."
    end
  end
end