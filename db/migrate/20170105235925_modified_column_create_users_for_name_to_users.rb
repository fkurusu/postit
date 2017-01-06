class ModifiedColumnCreateUsersForNameToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :CreateUsers, :name
  end
end
