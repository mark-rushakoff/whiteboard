class Item < ActiveRecord::Base
  KINDS = ['New face', 'Help', 'Interesting', 'Event']

  belongs_to :post

  validates :title, presence: true
  validates :kind, inclusion: KINDS

  attr_accessible :title, :description, :kind, :public, :post_id

  def self.public
    where(public: true)
  end

  def self.orphans
    where(post_id: nil).order("created_at ASC").group_by(&:kind)
  end

  def possible_template_name
    kind && "items/new_#{kind.downcase.gsub(" ", '_')}"
  end
end