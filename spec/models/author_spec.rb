require 'spec_helper'

describe Author do
  let(:author) {Author.new()}

  describe "::new" do
    it "can create a new user" do 
      expect(author).to be_an_instance_of(Author)
    end
  end

  describe "#name" do
    context "with a name" do
      before {author.save}

      it "is valid" do
        expect(author).to be_valid
      end
    end
end