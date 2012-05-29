require 'spec_helper'

describe ItemsController do
  before do
    request.session[:logged_in] = true
  end

  describe "#create" do
    it "should allow you to create an item" do
      expect {
        post :create, item: attributes_for(:item)
      }.should change { Item.count }.by(1)
    end

    it "should redirect to root on success" do
      post :create, item: attributes_for(:item)
      response.location.should == 'http://test.host/'
    end

    it "should render new on failure" do
      post :create, item: {}
      response.should render_template 'items/new'
    end

    it "sets the post_id if one is provided" do
      standup_post = create(:post)
      expect {
        post :create, item: attributes_for(:item), post_id: standup_post.id
      }.should change { standup_post.items.count }.by(1)
      response.should redirect_to(edit_post_path(standup_post))
    end
  end

  describe '#new' do
    it "should create a new Item object" do
      get :new
      assigns[:item].should be_new_record
      response.should be_ok
    end

    it "should render a new face form if requested" do
      get :new, kind: 'face'
      response.should render_template('items/new_face')
    end

    it "uses the params to create the new item so you can set defaults in the link" do
      get :new, item: { kind: 'Interesting' }
      assigns[:item].kind.should == 'Interesting'
    end
  end

  describe "#index" do
    it "generates a hash of items by type" do
      help, new_face, interesting = create(:item, kind: "Help"), create(:item, kind: "New face"), create(:item, kind: "Interesting")

      get :index
      assigns[:items]['New face'].should    == [ new_face ]
      assigns[:items]['Help'].should        == [ help ]
      assigns[:items]['Interesting'].should == [ interesting ]
      response.should be_ok
    end

    it "generates a blog hash with only public items" do
      help, new_face, interesting = create(:item, kind: "Help"), create(:item, kind: "New face"), create(:item, kind: "Interesting")
      public_help, public_new_face, public_interesting = create(:item, kind: "Help", public: true), create(:item, kind: "New face", public: true), create(:item, kind: "Interesting", public: true)

      get :index
      assigns[:public_items]['New face'].should    == [ public_new_face ]
      assigns[:public_items]['Help'].should        == [ public_help ]
      assigns[:public_items]['Interesting'].should == [ public_interesting ]
      response.should be_ok
    end

    it "does not include items which are associated with a post" do
      post = create(:post)
      help, new_face, interesting = create(:item, kind: "Help"), create(:item, kind: "New face"), create(:item, kind: "Interesting")
      posted_item = create(:item, post: post)

      get :index
      assigns[:items]['New face'].should    == [ new_face ]
      assigns[:items]['Help'].should        == [ help ]
      assigns[:items]['Interesting'].should == [ interesting ]
      response.should be_ok
    end
  end

  describe "#destroy" do
    it "should destroy the item" do
      item = create(:item)
      delete :destroy, id: item.id
      Item.find_by_id(item.id).should_not be
      response.should redirect_to('/')

    end

    it "redirects to the post if there is one" do
      item = create(:item, post: create(:post))
      delete :destroy, id: item.id, post_id: item.post
      Item.find_by_id(item.id).should_not be
      response.should redirect_to(edit_post_path(item.post))
    end
  end

  describe "#edit" do
    it "should edit the item" do
      item = create(:item)
      get :edit, id: item.id
      assigns[:item].should == item
      response.should render_template 'items/new'
    end
  end

  describe "#update" do
    it "should update the item" do
      item = create(:item)
      put :update, id: item.id, item: { title: "New Title" }
      item.reload.title.should == "New Title"
      response.should redirect_to('/')
    end

    it "redirects to the post if there is one" do
      item = create(:item, post: create(:post))
      put :update, id: item.id, post_id: item.post, item: { title: "New Title" }
      item.reload.title.should == "New Title"
      response.should redirect_to(edit_post_path(item.post))
    end
  end
end