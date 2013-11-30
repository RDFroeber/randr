class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :author

  validates :user_id, :author_id, presence: true
end