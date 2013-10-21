class AddFavorites < ActiveRecord::Migration
  def change
   create_table :favorites do |t|
      t.references :user, null: false, index: true
      t.references :author, null: false
      t.boolean :notify, default: true
      t.timestamps
    end

    #Adding a Foreign Key constraint for user_id and author_id
    reversible do |dir|
      dir.up do
        execute <<-SQL  #Executes RAW SQL
          ALTER TABLE favorites
          ADD CONSTRAINT fk_users
          FOREIGN KEY (user_id)
          REFERENCES users(id),
          ADD CONSTRAINT fk_authors
          FOREIGN KEY (author_id)
          REFERENCES authors(id)
        SQL
        #End of SQL string
      end
    end

  end
end
