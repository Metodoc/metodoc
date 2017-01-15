require 'test_helper'

class ParamsConfigTypeDocsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @params_config_type_doc = params_config_type_docs(:one)
  end

  test "should get index" do
    get params_config_type_docs_url
    assert_response :success
  end

  test "should get new" do
    get new_params_config_type_doc_url
    assert_response :success
  end

  test "should create params_config_type_doc" do
    assert_difference('ParamsConfigTypeDoc.count') do
      post params_config_type_docs_url, params: { params_config_type_doc: {  } }
    end

    assert_redirected_to params_config_type_doc_url(ParamsConfigTypeDoc.last)
  end

  test "should show params_config_type_doc" do
    get params_config_type_doc_url(@params_config_type_doc)
    assert_response :success
  end

  test "should get edit" do
    get edit_params_config_type_doc_url(@params_config_type_doc)
    assert_response :success
  end

  test "should update params_config_type_doc" do
    patch params_config_type_doc_url(@params_config_type_doc), params: { params_config_type_doc: {  } }
    assert_redirected_to params_config_type_doc_url(@params_config_type_doc)
  end

  test "should destroy params_config_type_doc" do
    assert_difference('ParamsConfigTypeDoc.count', -1) do
      delete params_config_type_doc_url(@params_config_type_doc)
    end

    assert_redirected_to params_config_type_docs_url
  end
end
