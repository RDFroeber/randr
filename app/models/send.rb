class Send < ActiveRecord::Base
  def self.send_mail
    Dop.all.each do |dop|
      UserMailer.welcome_email(dop).deliver if within_thirty_four_weeks?(date) && seventh_day(dop.date) 
    end
  end

  def self.seventh_day?(date)
    days_diff % 7 == 0
  end

  def self.within_thirty_four_weeks?(date)
    days_diff(date) <= 34.weeks
  end

  def self.days_diff(date)
    (Time.zone.now - date).to_i / 1.day
  end
end