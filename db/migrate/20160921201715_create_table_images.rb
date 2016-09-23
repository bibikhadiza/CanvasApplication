class CreateTableImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filepath
      t.string :name
      t.integer :user_id
      t.integer :category_id
    end
  end
end
