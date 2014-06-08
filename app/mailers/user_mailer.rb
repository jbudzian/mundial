class UserMailer < ActionMailer::Base
  default from: "noreply@sollers.pl"
  
  def reset_password_email(user, new_password)
    @user = user
    @new_password = new_password
    mail(to: @user.email, subject: 'Mundial - password reset')
  end
end
