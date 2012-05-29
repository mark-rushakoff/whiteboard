class ChangeBlogableToPublicOnItems < ActiveRecord::Migration
  def change
    rename_column :items, :blogable, :public
  end
end