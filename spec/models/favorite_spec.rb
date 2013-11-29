require 'spec_helper'

describe Favorite do
  let(:author) {Author.create(name: "Kim Harrison")}
  let(:fav) {Favorite.new()}

  describe "::new" do
    it "can create a new favorite" do 
      expect(fav).to be_an_instance_of(Favorite)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:author_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:author) }
  end

end