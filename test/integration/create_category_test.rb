require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do 
      post categories_path,params:{category:{name: "Sports"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports",response.body 
  end
  # for invalid submission of category
  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do  # count will not difference
      post categories_path,params:{category:{name: " "}} # if category name is empty
      
    end
        assert_match "errors",response.body  # check for error message 
        assert_select 'h2' # checking for error message display or not
  end
end
