class AddFutureReleaseToBooks < ActiveRecord::Migration
  def change
    add_column :books, :future_release, :boolean
  end
end
