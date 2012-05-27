require 'spec_helper'

describe PostsController do
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
      put :update, id: post.id, post: { title: "New Title" }
      post.reload.title.should == "New Title"
    end
  end

  describe "#index" do
    it "renders an index of posts" do
      post = create(:post)
      get :index
      assigns[:posts].should == [ post ]
    end
  end
end