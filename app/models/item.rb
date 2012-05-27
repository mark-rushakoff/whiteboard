class Item < ActiveRecord::Base
  KINDS = ['New face', 'Help', 'Interesting']

  belongs_to :post

  validates :title, presence: true
  validates :kind, inclusion: KINDS

  attr_accessible :title, :description, :kind, :blogable

  def self.blogable
    where(blogable: true)
  end

  def self.orphans
    where(post_id: nil)
  end
end