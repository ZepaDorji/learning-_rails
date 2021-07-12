require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
    def setup # runs before any following tests
        @category = Category.new(name: "Sports") # making this instant as global 
    end
    test "category should be valid" do 
        #@category = Category.new(name: "Sports")
        assert @category.valid?  # assert check for true
    end
    test "name should be present" do 
        @category.name = ""
        assert_not @category.valid?  # assert_not check for false
    end
    test "name should be unique" do
        @category.save  # for uniquness, atlest one data should present in db, so we are saving sport
        @category2 = Category.new(name: "Sports")  # creating category with same name
        assert_not @category2.valid?
    end
    test "name should not be too long" do
        @category.name = "Z"*26 # max len = 25, checking for 25
        assert_not @category.valid?
    end
    test "name should not be too short" do 
        @category.name = "zz" # min len = 3, checking for 2
        assert_not @category.valid?
    end
end