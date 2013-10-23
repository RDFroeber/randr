class Favorite < ActiveRecord::Base
   belongs_to :user
   belongs_to :author
   
   has_many :books, :through => :authors

end