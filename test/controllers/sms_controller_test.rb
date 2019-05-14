class SmsControllerTest < ActionDispatch::IntegrationTest
  test "inbound call test with other method" do
    get api_inbound_sms_url
    assert_response :error
  end
end