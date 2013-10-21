class AddAuthors < ActiveRecord::Migration
  def change
   create_table :authors do |t|
      t.string :name, null: false
      t.boolean :alive, default: true
      t.timestamps
    end
  end
end
