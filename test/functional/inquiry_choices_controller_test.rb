require 'test_helper'

class InquiryChoicesControllerTest < ActionController::TestCase
  setup do
    @inquiry_choice = inquiry_choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inquiry_choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inquiry_choice" do
    assert_difference('InquiryChoice.count') do
      post :create, :inquiry_choice => @inquiry_choice.attributes
    end

    assert_redirected_to inquiry_choice_path(assigns(:inquiry_choice))
  end

  test "should show inquiry_choice" do
    get :show, :id => @inquiry_choice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @inquiry_choice.to_param
    assert_response :success
  end

  test "should update inquiry_choice" do
    put :update, :id => @inquiry_choice.to_param, :inquiry_choice => @inquiry_choice.attributes
    assert_redirected_to inquiry_choice_path(assigns(:inquiry_choice))
  end

  test "should destroy inquiry_choice" do
    assert_difference('InquiryChoice.count', -1) do
      delete :destroy, :id => @inquiry_choice.to_param
    end

    assert_redirected_to inquiry_choices_path
  end
end
