class AddFromToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :from, :string, default: 'Standup Blogger'
  end
end
