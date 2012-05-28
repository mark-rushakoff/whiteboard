class Post < ActiveRecord::Base
  has_many :items
  has_many :blogable_items, conditions: { blogable: true }, class_name: "Item"

  validates :title, presence: true

  attr_accessible :title

  def adopt_all_the_items
    self.items = Item.where(post_id: nil, bumped: false)
  end

  def deliver_email
    if sent_at
      raise "Duplicate Email"
    else
      PostMailer.send_to_all(self).deliver
      self.sent_at = Time.now
      self.save!
    end
  end
end