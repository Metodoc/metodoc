require 'test_helper'

class DocTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @doc_type = doc_types(:one)
  end

  test "should get index" do
    get doc_types_url
    assert_response :success
  end

  test "should get new" do
    get new_doc_type_url
    assert_response :success
  end

  test "should create doc_type" do
    assert_difference('DocType.count') do
      post doc_types_url, params: { doc_type: {  } }
    end

    assert_redirected_to doc_type_url(DocType.last)
  end

  test "should show doc_type" do
    get doc_type_url(@doc_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_doc_type_url(@doc_type)
    assert_response :success
  end

  test "should update doc_type" do
    patch doc_type_url(@doc_type), params: { doc_type: {  } }
    assert_redirected_to doc_type_url(@doc_type)
  end

  test "should destroy doc_type" do
    assert_difference('DocType.count', -1) do
      delete doc_type_url(@doc_type)
    end

    assert_redirected_to doc_types_url
  end
end
