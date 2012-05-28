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

  describe '#deliver_email' do
    it "sends an email" do
      post = create(:post, items: [create(:item)])
      post.deliver_email
      ActionMailer::Base.deliveries.last.to.should == ['mkocher@pivotallabs.com']
    end

    it "raises an error if you send it twice" do
      post = create(:post, items: [create(:item)])
      post.deliver_email
      ActionMailer::Base.deliveries.last.to.should == ['mkocher@pivotallabs.com']
      expect { post.deliver_email }.should raise_error("Duplicate Email")
    end
  end
end