require 'test_helper'

class TileDefinitionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tile_definitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tile_definition" do
    assert_difference('TileDefinition.count') do
      post :create, :tile_definition => { }
    end

    assert_redirected_to tile_definition_path(assigns(:tile_definition))
  end

  test "should show tile_definition" do
    get :show, :id => tile_definitions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tile_definitions(:one).to_param
    assert_response :success
  end

  test "should update tile_definition" do
    put :update, :id => tile_definitions(:one).to_param, :tile_definition => { }
    assert_redirected_to tile_definition_path(assigns(:tile_definition))
  end

  test "should destroy tile_definition" do
    assert_difference('TileDefinition.count', -1) do
      delete :destroy, :id => tile_definitions(:one).to_param
    end

    assert_redirected_to tile_definitions_path
  end
end
