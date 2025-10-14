require "test_helper"

class WorksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @work = works(:one)
  end

  test "should redirect to login when not signed in" do
    get works_url
    assert_redirected_to new_user_session_url
  end

  test "should get index when signed in" do
    sign_in @user
    get works_url
    assert_response :success
  end

  test "should get new when signed in" do
    sign_in @user
    get new_work_url
    assert_response :success
  end

  test "should create work when signed in" do
    sign_in @user
    assert_difference("Work.count") do
      post works_url, params: { work: { title: "Test Work", body: "Test Body" } }
    end

    assert_redirected_to work_url(Work.last)
  end

  test "should show work when signed in" do
    sign_in @user
    get work_url(@work)
    assert_response :success
  end
end
