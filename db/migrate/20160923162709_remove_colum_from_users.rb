class RemoveColumFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :like_id, :integer
    remove_column :users, :dislike_id, :integer
  end
end
