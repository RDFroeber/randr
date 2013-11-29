require 'spec_helper'

describe Book do
  let(:author) {Author.create(name: "Kim Harrison")}
  let(:book) {Book.new(title: "The Undead Pool", author_id: author.id, isbn: "978-0061957932", published_date: "2014-02-25")}

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
    it { should belong_to(:author) }
    it { should have_many(:libraries) }
  end

end