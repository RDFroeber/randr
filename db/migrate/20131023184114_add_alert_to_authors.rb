class AddAlertToAuthors < ActiveRecord::Migration
  def change
      add_column :authors, :alert, :boolean
  end
end
