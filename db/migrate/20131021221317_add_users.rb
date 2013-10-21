class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
    
    reversible do |dir|
         dir.up do 
            execute <<-SQL
               DELETE FROM users;
            SQL
         end
      end

    add_index :users, :email, unique: true
  end
end
