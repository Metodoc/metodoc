require 'test_helper'

class RdfControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rdf_index_url
    assert_response :success
  end

end
