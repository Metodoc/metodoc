require 'test_helper'

class FunctionsPapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @functions_paper = functions_papers(:one)
  end

  test "should get index" do
    get functions_papers_url
    assert_response :success
  end

  test "should get new" do
    get new_functions_paper_url
    assert_response :success
  end

  test "should create functions_paper" do
    assert_difference('FunctionsPaper.count') do
      post functions_papers_url, params: { functions_paper: {  } }
    end

    assert_redirected_to functions_paper_url(FunctionsPaper.last)
  end

  test "should show functions_paper" do
    get functions_paper_url(@functions_paper)
    assert_response :success
  end

  test "should get edit" do
    get edit_functions_paper_url(@functions_paper)
    assert_response :success
  end

  test "should update functions_paper" do
    patch functions_paper_url(@functions_paper), params: { functions_paper: {  } }
    assert_redirected_to functions_paper_url(@functions_paper)
  end

  test "should destroy functions_paper" do
    assert_difference('FunctionsPaper.count', -1) do
      delete functions_paper_url(@functions_paper)
    end

    assert_redirected_to functions_papers_url
  end
end
