require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get getsettings" do
    get settings_getsettings_url
    assert_response :success
  end

  test "should get getadministrate" do
    get settings_getadministrate_url
    assert_response :success
  end

end
