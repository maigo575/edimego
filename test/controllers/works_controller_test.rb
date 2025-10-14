require "test_helper"

class WorksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @work = works(:one)
  end

  test "should require authentication for works" do
    get works_url
    assert_response :forbidden
  end

  test "user should be valid" do
    assert @user.valid?
    assert @user.persisted?
  end

  test "work should belong to user" do
    assert_equal @user, @work.user
  end

  test "work should have valid attributes" do
    assert @work.valid?
    assert @work.persisted?
  end

  test "user should have works" do
    assert @user.works.any?
  end
end
