require 'spec_helper'

describe PostMailer do
  describe 'send_to_all' do
    let(:post) { create(:post, items: [ create(:item) ]) }
    let(:mail) { PostMailer.send_to_all(post) }

    it 'sets the title to be the posts title' do
      mail.subject.should == post.title
    end

    it 'sets the from address' do
      mail.from.should == ["noreply@pivotallabs.com"]
    end

    it 'renders the items in the body of the message' do
      mail.body.should include(post.items.first.title)
    end
  end
end
