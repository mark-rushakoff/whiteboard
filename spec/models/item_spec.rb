require 'spec_helper'

describe Item do
  let(:item) { build_stubbed(:item) }

  it { should belong_to(:post) }
  it { should validate_presence_of(:title) }

  describe "kind" do
    describe "should allow valid kinds - " do
      ['New face', 'Help', 'Interesting'].each do |kind|
        it kind do
          item.kind = kind
          item.should be_valid
        end
      end
    end

    it "should not allow other kinds" do
      item.kind = "foobar"
      item.should_not be_valid
    end
  end
end