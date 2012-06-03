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

  describe '#title_for_email' do
    it 'prepends [Standup][SF] and the date' do
      post = create(:post, title: "With Feeling", created_at: Time.parse("2012-06-02 12:00:00 -0700"))
      post.title_for_email.should == "[Standup][SF] 06/02/12: With Feeling"
    end
  end

  describe '#title_for_blog' do
    it 'prepends the data' do
      post = create(:post, title: "With Feeling", created_at: Time.parse("2012-06-02 12:00:00 -0700"))
      post.title_for_blog.should == "06/02/12: With Feeling"
    end
  end

  describe '#deliver_email' do
    it "sends an email" do
      post = create(:post, items: [create(:item)])
      post.deliver_email
      ActionMailer::Base.deliveries.last.to.should == ['everyone@example.com']
    end

    it "raises an error if you send it twice" do
      post = create(:post, items: [create(:item)])
      post.deliver_email
      ActionMailer::Base.deliveries.last.to.should == ['everyone@example.com']
      expect { post.deliver_email }.should raise_error("Duplicate Email")
    end
  end

  describe '#items_by_type' do
    it "orders by created_at asc" do
      post = create(:post)
      items = [ create(:item, created_at: Time.now), create(:item, created_at: 2.days.ago )]
      post.items = items
      post.items_by_type['Help'].should == items.reverse
    end
  end
end