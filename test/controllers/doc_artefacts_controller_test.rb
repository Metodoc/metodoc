require 'test_helper'

class DocArtefactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @doc_artefact = doc_artefacts(:one)
  end

  test "should get index" do
    get doc_artefacts_url
    assert_response :success
  end

  test "should get new" do
    get new_doc_artefact_url
    assert_response :success
  end

  test "should create doc_artefact" do
    assert_difference('DocArtefact.count') do
      post doc_artefacts_url, params: { doc_artefact: {  } }
    end

    assert_redirected_to doc_artefact_url(DocArtefact.last)
  end

  test "should show doc_artefact" do
    get doc_artefact_url(@doc_artefact)
    assert_response :success
  end

  test "should get edit" do
    get edit_doc_artefact_url(@doc_artefact)
    assert_response :success
  end

  test "should update doc_artefact" do
    patch doc_artefact_url(@doc_artefact), params: { doc_artefact: {  } }
    assert_redirected_to doc_artefact_url(@doc_artefact)
  end

  test "should destroy doc_artefact" do
    assert_difference('DocArtefact.count', -1) do
      delete doc_artefact_url(@doc_artefact)
    end

    assert_redirected_to doc_artefacts_url
  end
end
