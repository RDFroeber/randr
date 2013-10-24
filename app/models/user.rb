class User < ActiveRecord::Base
   validates :email, presence: true,  uniqueness: true

   has_many :favorites
   has_many :authors, :through => :favorites
   has_one :library
   has_many :books, :through => :library

   has_secure_password

   def author_alert
      @user.authors.each do |author|
         if author.books.where(future_release: true)
            author.author_alert = true
         else
            author.author_alert = false
         end
      end
      alerts = self.authors.where(alert: true)
   end
end