require 'spec_helper'

describe User do
  let(:user) {User.new(name: "Raleigh D", email: "raleigh@d.me", password: "readingisfun", password_confirmation: "readingisfun")}

  describe "::new" do
    it "can create a new user" do 
      expect(user).to be_an_instance_of(User)
    end
  end

  describe "#name" do
    context "with a name" do
      before {user.save}

      it "is valid" do
        expect(user).to be_valid
      end
    end

    context "without a name" do
      it "is not valid" do
        user.name = nil
        expect(user).to have(1).errors_on(:name)
      end
    end
  end

  describe "#email" do
    context "with an email" do
      before {user.save}

      it "is valid" do
        expect(user).to be_valid
      end
    end

    context "without an email" do
      it "is not valid" do
        user.email = nil
        expect(user).to have(1).errors_on(:email)
      end
    end

    context "with a taken email" do
      before {user.save}

      let!(:twin) do
        User.create(name: "Twin Raleigh", email: "raleigh@d.me", password: "The Twin", password_confirmation: "The Twin")
      end

      it "is not valid" do
        expect(twin).to have(1).errors_on(:email)
      end
    end

    context "with a taken email, different case" do
      before {user.save}

      let!(:twin) do
        User.create(name: "Twin Raleigh", email: "RALeigh@D.me", password: "The Twin", password_confirmation: "The Twin")
      end

      it "is not valid" do
        expect(twin).to have(1).errors_on(:email)
      end
    end
  end

  describe "#password_digest" do
    context "with a password and password_confirmation" do
      before {user.save}

      it "is valid" do
        expect(user).to be_valid
      end
    end

    context "without a password and password_confirmation" do
      it "is not valid" do
        user.password = nil
        user.password_confirmation = nil
        expect(user).to_not be_valid
      end
    end 

    context "when password confirmation is nil" do
      it "is not valid" do
        user.password_confirmation = nil
        expect(user).to_not be_valid
      end
    end

    context "when password does not match confirmation" do
      it "is not valid" do
        user.password_confirmation = "mismatch"
        expect(user).to_not be_valid
      end
    end

    context "when a password is too short" do
      before { user.password = user.password_confirmation = "r" * 5 }

      it "is not valid" do
          expect(user).to_not be_valid
      end
    end
  end

  describe "#favorites" do

  end
  describe "#authors" do

  end
  describe "#library" do

  end
  describe "#books" do

  end

  
end