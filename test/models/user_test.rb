require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should create user with valid attributes" do
    user = User.new(
      email: "test@example.com",
      password: "password123",
      penname: "テストユーザー"
    )
    assert user.valid?
  end

  test "should not create user without email" do
    user = User.new(password: "password123", penname: "テストユーザー")
    assert_not user.valid?
  end

  test "should not create user without password" do
    user = User.new(email: "test@example.com", penname: "テストユーザー")
    assert_not user.valid?
  end
end
