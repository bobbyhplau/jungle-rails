require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should create a valid user if everything is working" do
      user = User.create({
        first_name: "Test",
        last_name: "User",
        email: "test1@test.com",
        password: "test",
        password_confirmation: "test"
      })
      expect(user).to be_valid
    end
    it "should have matching password and password_confirmation fields" do
      user = User.create({
        first_name: "Test",
        last_name: "User",
        email: "test1@test.com",
        password: "test",
        password_confirmation: "not-test"
      })
      expect(user).to_not be_valid
    end
    it "should have values in password and password_confirmation fields" do
      user = User.create({
        first_name: "Test",
        last_name: "User",
        email: "test1@test.com",
        password: "",
        password_confirmation: ""
      })
      expect(user).to_not be_valid
    end
    it "should be unique without being case sensitive" do
      user = User.create({
        first_name: "Test",
        last_name: "User",
        email: "test1@test.com",
        password: "test",
        password_confirmation: "test"
      })
      user2 = User.create({
        first_name: "Bob",
        last_name: "Tester",
        email: "TEST1@TEST.com",
        password: "bobbob",
        password_confirmation: "bobbob"
      })
      expect(user).to be_valid
      expect(user2).to_not be_valid
    end
    it "should have a first name" do
      user = User.create({
        first_name: nil,
        last_name: "User",
        email: "test1@test.com",
        password: "test",
        password_confirmation: "test"
      })
      expect(user).to_not be_valid
    end
    it "should have a last name" do
      user = User.create({
        first_name: "Test",
        last_name: nil,
        email: "test1@test.com",
        password: "test",
        password_confirmation: "test"
      })
      expect(user).to_not be_valid
    end
    it "should have an email" do
      user = User.create({
        first_name: "Test",
        last_name: "User",
        email: nil,
        password: "test",
        password_confirmation: "test"
      })
      expect(user).to_not be_valid
    end
    it "should have passwords with a minimum length of 4" do
      user = User.create({
        first_name: "Test",
        last_name: "User",
        email: "test1@test.com",
        password: "123",
        password_confirmation: "123"
      })
      expect(user).to_not be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create({
        first_name: "Test",
        last_name: "User",
        email: "test1@test.com",
        password:"test",
        password_confirmation: "test"
      })
    end
    it "should return a user if the email and password match" do
      authenticated_user = User.authenticate_with_credentials("test1@test.com", "test")
      expect(authenticated_user).to be_valid
    end
    it "should log them in even if there are spaces around the email address" do
      authenticated_user = User.authenticate_with_credentials(" test1@test.com ", "test")
      expect(authenticated_user).to be_valid
    end
    it "should log you in even if you get the case mixed up" do
      authenticated_user = User.authenticate_with_credentials("tESt1@TESt.cOM", "test")
      expect(authenticated_user).to be_valid
    end
  end
end
