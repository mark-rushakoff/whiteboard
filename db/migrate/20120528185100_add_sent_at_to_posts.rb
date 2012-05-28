class AddSentAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sent_at, :timestamp
  end
end
