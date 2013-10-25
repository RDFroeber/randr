desc "This task is called by the Heroku scheduler add-on"
task :pull_new_results => :environment do
   lookup = Search.new
   search = lookup.new_favorites
   lookup.save_favorites(search)
end

task :send_notification => :environment do
  UserMailer.notify_email(current_user).deliver
end