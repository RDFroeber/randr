class User < ActiveRecord::Base
   validates :email, presence: true,  uniqueness: true

   has_many :favorites
   has_many :authors, :through => :favorites

   has_secure_password

   def author_alert
      # TODO Add author_alert method to user model
      alerted = self.authors.where(alert: true)
   end
end