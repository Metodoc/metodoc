require 'test_helper'

class DocTypeConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @doc_type_config = doc_type_configs(:one)
  end

  test "should get index" do
    get doc_type_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_doc_type_config_url
    assert_response :success
  end

  test "should create doc_type_config" do
    assert_difference('DocTypeConfig.count') do
      post doc_type_configs_url, params: { doc_type_config: {  } }
    end

    assert_redirected_to doc_type_config_url(DocTypeConfig.last)
  end

  test "should show doc_type_config" do
    get doc_type_config_url(@doc_type_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_doc_type_config_url(@doc_type_config)
    assert_response :success
  end

  test "should update doc_type_config" do
    patch doc_type_config_url(@doc_type_config), params: { doc_type_config: {  } }
    assert_redirected_to doc_type_config_url(@doc_type_config)
  end

  test "should destroy doc_type_config" do
    assert_difference('DocTypeConfig.count', -1) do
      delete doc_type_config_url(@doc_type_config)
    end

    assert_redirected_to doc_type_configs_url
  end
end
