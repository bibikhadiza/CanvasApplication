class CreateTableDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.integer :user_id
      t.integer :image_id
    end
  end
end
