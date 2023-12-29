class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :details
      t.string :category
      t.integer :likes
      t.string :name

      t.timestamps
    end
  end
end
