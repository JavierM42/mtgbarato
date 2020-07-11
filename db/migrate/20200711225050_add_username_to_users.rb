class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_name, :string, null: true
  end
end
