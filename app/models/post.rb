class Post < ActiveRecord::Base
  has_many :items
  has_many :blogable_items, conditions: { blogable: true }, class_name: "Item"

  validates :title, presence: true

  attr_accessible :title

  def adopt_all_the_items
    self.items = Item.where(post_id: nil, bumped: false)
  end
end