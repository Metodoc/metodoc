require 'test_helper'

class OntologiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ontology = ontologies(:one)
  end

  test "should get index" do
    get ontologies_url
    assert_response :success
  end

  test "should get new" do
    get new_ontology_url
    assert_response :success
  end

  test "should create ontology" do
    assert_difference('Ontology.count') do
      post ontologies_url, params: { ontology: {  } }
    end

    assert_redirected_to ontology_url(Ontology.last)
  end

  test "should show ontology" do
    get ontology_url(@ontology)
    assert_response :success
  end

  test "should get edit" do
    get edit_ontology_url(@ontology)
    assert_response :success
  end

  test "should update ontology" do
    patch ontology_url(@ontology), params: { ontology: {  } }
    assert_redirected_to ontology_url(@ontology)
  end

  test "should destroy ontology" do
    assert_difference('Ontology.count', -1) do
      delete ontology_url(@ontology)
    end

    assert_redirected_to ontologies_url
  end
end
