class Favorite < ActiveRecord::Base
   belongs_to :users
   belongs_to :authors
   
   has_many :books, :through => :authors

end