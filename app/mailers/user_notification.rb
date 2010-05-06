class UserNotification < ActionMailer::Base
  default :from => "from@example.com"

  def password_reset_email(user)
    @url = edit_password_reset_url(user.perishable_token)
    mail(:to => user.email, :subject => "Password Reset Instructions")
  end
end