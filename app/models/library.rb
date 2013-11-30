class Library < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :authors, :through => :book

  validates :user_id, :book_id, presence: true
end