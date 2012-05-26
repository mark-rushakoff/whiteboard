class Item < ActiveRecord::Base
  KINDS = ['New face', 'Help', 'Interesting']

  validates :title, presence: true
  validates :kind, inclusion: KINDS

  attr_accessible :title, :description, :kind, :blogable

  def self.blogable
    where(blogable: true)
  end
end