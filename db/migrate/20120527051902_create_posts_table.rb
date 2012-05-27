class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.boolean :sent

      t.timestamps
    end
  end
end
