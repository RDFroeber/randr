require 'spec_helper'

describe Library do
  let(:author) {Author.create(name: "Kim Harrison")}
  let(:book) {Book.new(title: "The Undead Pool", author_id: author.id, isbn: "978-0061957932", published_date: "2014-02-25")}
  let(:lib) {Library.new()}

  describe "::new" do
    it "can create a new library" do 
      expect(lib).to be_an_instance_of(Library)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:book_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
    it { should have_many(:authors).through(:book) }
  end

end