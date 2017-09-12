class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
  		add_index :users, :email, unique: true
#Rails method called add_index to add an index on the email column of the users table
  end
end
