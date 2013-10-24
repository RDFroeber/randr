class ChangeIsbnDataTypeInBooks < ActiveRecord::Migration
  def change
      change_column :books, :isbn, :string, :null => false
  end
end
