class RemoveColumnFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :like_id, :integer
    remove_column :images, :dislike_id, :integer
  end
end
