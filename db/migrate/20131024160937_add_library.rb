class AddLibrary < ActiveRecord::Migration
  def change
   create_table :libraries do |t|
      t.references :user, null: false, index: true
      t.references :book, null: false
      t.timestamps
    end

    #Adding a Foreign Key constraint for user_id and author_id
    reversible do |dir|
      dir.up do
        execute <<-SQL  #Executes RAW SQL
          ALTER TABLE libraries
          ADD CONSTRAINT fk_users
          FOREIGN KEY (user_id)
          REFERENCES users(id),
          ADD CONSTRAINT fk_books
          FOREIGN KEY (book_id)
          REFERENCES books(id)
        SQL
        #End of SQL string
      end
    end

  end
end