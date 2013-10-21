class Author < ActiveRecord::Base

   has_many :favorites
   has_many :books

end