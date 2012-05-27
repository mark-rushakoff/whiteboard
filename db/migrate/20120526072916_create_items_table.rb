class CreateItemsTable < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :title
      t.text :description
      t.string :kind
      t.integer :post_id
      t.boolean :blogable
      t.boolean :bumped, default: false

      t.timestamps
    end
  end
end
