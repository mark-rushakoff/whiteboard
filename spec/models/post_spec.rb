require 'spec_helper'

describe Post do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should have_many(:items) }
  end

  describe "#adopt_all_items" do
    it "claims all items not associated with a post" do
      old_post = create(:post)
      claimed_item = create(:item, post: old_post)
      unclaimed_item = create(:item)

      post = create(:post)
      post.adopt_all_the_items

      post.items.should == [unclaimed_item]
    end

    it "does not adoped bumped items" do
      old_post = create(:post)
      claimed_item = create(:item, post: old_post)
      unclaimed_item = create(:item)
      bumped_item = create(:item, bumped: true)

      post = create(:post)
      post.adopt_all_the_items

      post.items.should == [unclaimed_item]
    end
  end
end