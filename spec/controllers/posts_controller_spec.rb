require 'spec_helper'

describe PostsController do
  before do
    request.session[:logged_in] = true
  end

  describe "#create" do
    it "creates a post" do
      expect do
        post :create, post: { title: "Standup 12/12/12"}
      end.should change { Post.count }.by(1)
      response.should be_redirect
    end

    it "adopts all items" do
      item = create(:item)
      post :create, post: { title: "Standup 12/12/12"}
      assigns[:post].items.should == [ item ]
    end
  end

  describe "#edit" do
    it "shows the post for editing" do
      post = create(:post)
      get :edit, id: post.id
      assigns[:post].should == post
      response.should be_ok
    end
  end

  describe "#update" do
    it "updates the post" do
      post = create(:post)
      put :update, id: post.id, post: { title: "New Title", from: "Matthew & Matthew" }
      post.reload.title.should == "New Title"
      post.from.should == "Matthew & Matthew"
    end
  end

  describe "#index" do
    it "renders an index of posts" do
      post = create(:post)
      get :index
      assigns[:posts].should == [ post ]
    end
  end

  describe "#send" do
    it "sends the email" do
      post = create(:post, items: [ create(:item) ] )
      put :send_email, id: post.id
      response.should redirect_to(edit_post_path(post))
      ActionMailer::Base.deliveries.last.to.should == ['mkocher@pivotallabs.com']
    end

    it "does not allow resending" do
      post = create(:post, sent_at: Time.now )
      put :send_email, id: post.id
      response.should redirect_to(edit_post_path(post))
      flash[:error].should == "The message has already been sent"
    end
  end
end