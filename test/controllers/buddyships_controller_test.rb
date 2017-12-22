require 'test_helper'

class BuddyshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @buddyship = buddyships(:one)
  end

  test "should get index" do
    get buddyships_url
    assert_response :success
  end

  test "should get new" do
    get new_buddyship_url
    assert_response :success
  end

  test "should create buddyship" do
    assert_difference('Buddyship.count') do
      post buddyships_url, params: { buddyship: { buddy_id: @buddyship.buddy_id, create: @buddyship.create, destroy: @buddyship.destroy, user_id: @buddyship.user_id } }
    end

    assert_redirected_to buddyship_url(Buddyship.last)
  end

  test "should show buddyship" do
    get buddyship_url(@buddyship)
    assert_response :success
  end

  test "should get edit" do
    get edit_buddyship_url(@buddyship)
    assert_response :success
  end

  test "should update buddyship" do
    patch buddyship_url(@buddyship), params: { buddyship: { buddy_id: @buddyship.buddy_id, create: @buddyship.create, destroy: @buddyship.destroy, user_id: @buddyship.user_id } }
    assert_redirected_to buddyship_url(@buddyship)
  end

  test "should destroy buddyship" do
    assert_difference('Buddyship.count', -1) do
      delete buddyship_url(@buddyship)
    end

    assert_redirected_to buddyships_url
  end
end
