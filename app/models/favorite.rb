class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :author

  validates :author_id, :user_id, presence: true
end