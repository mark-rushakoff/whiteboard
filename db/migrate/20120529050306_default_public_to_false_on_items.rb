class DefaultPublicToFalseOnItems < ActiveRecord::Migration
  def up
    change_column_default :items, :public, false
  end
end
