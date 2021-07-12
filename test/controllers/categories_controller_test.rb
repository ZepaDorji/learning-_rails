require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports") # creating category called Sport
    @admin_user = User.create(username: "Zepa", email: "zepa@gmail.com",
                              password: "zepa", admin: true) # admin adding
  end


  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should create category" do # creating another article and checking..
    sign_in_as(@admin_user)
    assert_difference('Category.count',1) do
      post categories_url, params: { category: {name:"Travel" } }
    end

     assert_redirected_to category_url(Category.last)
   end

   test "should not create category if not admin" do # checking for admin to create the catgory checking..
    assert_no_difference('Category.count') do
      post categories_url, params: { category: {name:"Travel" } }
    end

     assert_redirected_to categories_url # if user try to create new category redriect to categories listing page
   end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
