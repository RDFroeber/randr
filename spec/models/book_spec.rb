require 'spec_helper'

describe Book do
  let(:book) {Book.new(title: "J.K. Rowling")}

  describe "::new" do
    it "can create a new book" do 
      expect(book).to be_an_instance_of(Book)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:isbn) }
    it { should validate_presence_of(:published_date) }
  end

  describe "associations" do
    before { book.save }
    
    it { should belong_to(:author) }
    it { should have_many(:libraries) }
  end

end