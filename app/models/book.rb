class Book < ActiveRecord::Base
  belongs_to :author
  has_many :libraries

  validates :title, :author_id, :isbn, :published_date, presence: true
end