require 'spec_helper'

describe User do
  let(:user) {User.new(name: "Raleigh D", email: "raleigh@d.me", password: "readingisfun", password_confirmation: "readingisfun")}

  describe "::new" do
    it "can create a new user" do 
      expect(user).to be_an_instance_of(User)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    context "password" do
      it { should have_secure_password }
      it { should validate_presence_of(:password) }
      it { should validate_presence_of(:password_confirmation) }
      it { should ensure_length_of(:password).is_at_least(6) }
    end
  end

  describe "associations" do
    it { should have_many(:favorites) }
    it { should have_many(:authors).through(:favorites) }
    it { should have_one(:library) }
    it { should have_many(:books).through(:library) }
  end

end