class AddBooks < ActiveRecord::Migration
  def change
   create_table :books do |t|
      t.string :title, null: false
      t.references :author, null: false
      t.integer :isbn, null: false
      t.date :published_date, null: false
      t.string :img_url_sm
      t.string :img_url_lg
      t.string :buy_link
      t.timestamps
    end

    #Adding a Foreign Key constraint for author_id
    reversible do |dir|
      dir.up do
        execute <<-SQL  #Executes RAW SQL
          ALTER TABLE books
          ADD CONSTRAINT fk_authors
          FOREIGN KEY (author_id)
          REFERENCES authors(id)
        SQL
        #End of SQL string
      end
    end

  end
end
