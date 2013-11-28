require 'spec_helper'

describe Author do
  let(:author) {Author.new(name: "J.K. Rowling")}

  describe "::new" do
    it "can create a new author" do 
      expect(author).to be_an_instance_of(Author)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    before { author.save }
    
    it { should have_many(:favorites) }
    it { should have_many(:books) }
  end

end