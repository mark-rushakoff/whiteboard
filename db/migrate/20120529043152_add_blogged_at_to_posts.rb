class AddBloggedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :blogged_at, :timestamp
  end
end
