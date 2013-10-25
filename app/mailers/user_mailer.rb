class UserMailer < ActionMailer::Base

   default from: "favauthors@randr.me"

  def notify_email(user)
   @user = user

   mail(to: @user.email, subject: "Notification: Your Favorite Authors Have Upcoming Book Releases")
  end

end
