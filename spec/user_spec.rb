require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "verifies everything is provided" do
     new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password: "123", password_confirmation: "123")
     expect(new_user).to be_valid     
    end
    it "verifies passwords must match" do
      new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password: "123", password_confirmation: "124")
      expect(new_user).to_not be_valid
      expect(new_user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
     end
     it "verifies emails are unique" do
      new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password: "123", password_confirmation: "123")
      new_user_2 = User.create(name: "Charlie2", email: "charlieryancurry@gmail.com", password: "1234", password_confirmation: "1234")
      expect(new_user_2).to_not be_valid
      expect(new_user_2.errors.full_messages).to eq ["Email has already been taken"]
     end
     it "verifies name is provided" do
      new_user = User.create(email: "charlieryancurry@gmail.com", password: "123", password_confirmation: "123")
      expect(new_user).to_not be_valid
      expect(new_user.errors.full_messages).to eq ["Name can't be blank"]
     end
     it "verifies email is provided" do
      new_user = User.create(name: "Charlie", password: "123", password_confirmation: "123")
      expect(new_user).to_not be_valid
      expect(new_user.errors.full_messages).to eq ["Email can't be blank"]
     end
     it "verifies password is provided" do
      new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password_confirmation: "123")
      expect(new_user).to_not be_valid
      expect(new_user.errors.full_messages).to include "Password can't be blank"
     end
     it "verifies password_confirmation is provided" do
      new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password: "123")
      expect(new_user).to_not be_valid
      expect(new_user.errors.full_messages).to eq ["Password confirmation can't be blank"]
     end
  end
  describe '.authenticate_with_credentials' do
    it "returns nil if given an email that is not registered" do
      new_user = User.create(name: "Charlie", email: "charliEryancurry@gmail.com", password: "123", password_confirmation: "123")
      expect(new_user).to be_valid
      expect(User.authenticate_with_credentials("test@gmail.com", new_user.password)).to eq nil
    end
    it "returns nil if given the wrong password to authenticate" do
      new_user = User.create(name: "Charlie", email: "charliEryancurry@gmail.com", password: "123", password_confirmation: "123")
      expect(new_user).to be_valid
      expect(User.authenticate_with_credentials(new_user.email, "124")).to eq nil
    end
    it "verifies email is not case sensitive" do
      new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password: "123", password_confirmation: "123")
      expect(new_user).to be_valid
      expect(User.authenticate_with_credentials("charliEryancurry@gmail.com", "123")).to eq new_user
     end
     it "verifies email is trimmed" do
      new_user = User.create(name: "Charlie", email: "charlieryancurry@gmail.com", password: "123", password_confirmation: "123")
      expect(new_user).to be_valid
      expect(User.authenticate_with_credentials("  charlieryancurry@gmail.com  ", new_user.password)).to eq new_user
     end
  end
end
