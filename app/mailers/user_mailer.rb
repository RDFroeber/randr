class UserMailer < ActionMailer::Base

   default from: "raleigh@randr.me"

  def notify_email(user)
   @user = user

   mail(to: @user.email, subject: "Notification")
  end

end
