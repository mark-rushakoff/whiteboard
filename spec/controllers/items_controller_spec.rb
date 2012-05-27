require 'spec_helper'

describe ItemsController do
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
  end

  describe '#new' do
    it "should create a new Item object" do
      get :new
      assigns[:item].should be_new_record
      response.should be_ok
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
      blogable_help, blogable_new_face, blogable_interesting = create(:item, kind: "Help", blogable: true), create(:item, kind: "New face", blogable: true), create(:item, kind: "Interesting", blogable: true)

      get :index
      assigns[:blogable_items]['New face'].should    == [ blogable_new_face ]
      assigns[:blogable_items]['Help'].should        == [ blogable_help ]
      assigns[:blogable_items]['Interesting'].should == [ blogable_interesting ]
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
    end
  end
end