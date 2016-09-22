class CreateTableImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filepath
      t.string :name
      t.timestamps
      t.integer :user_id
      t.integer :like_id
      t.integer :dislike_id
      t.integer :category_id
    end
  end
end
