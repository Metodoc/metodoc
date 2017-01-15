require 'test_helper'

class ParamsConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @params_config = params_configs(:one)
  end

  test "should get index" do
    get params_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_params_config_url
    assert_response :success
  end

  test "should create params_config" do
    assert_difference('ParamsConfig.count') do
      post params_configs_url, params: { params_config: {  } }
    end

    assert_redirected_to params_config_url(ParamsConfig.last)
  end

  test "should show params_config" do
    get params_config_url(@params_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_params_config_url(@params_config)
    assert_response :success
  end

  test "should update params_config" do
    patch params_config_url(@params_config), params: { params_config: {  } }
    assert_redirected_to params_config_url(@params_config)
  end

  test "should destroy params_config" do
    assert_difference('ParamsConfig.count', -1) do
      delete params_config_url(@params_config)
    end

    assert_redirected_to params_configs_url
  end
end
