require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get welcome_index_url
    assert_response :success
  end

  def test_register
    get welcome_register_url
    assert_response :success
  end

end
