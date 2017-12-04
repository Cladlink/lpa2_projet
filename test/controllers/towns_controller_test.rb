require 'test_helper'

class TownsControllerTest < ActionController::TestCase
  setup do
    @town = towns(:one)
    @inexisting = towns(:inexisting)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:towns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  
  test "should create town" do
    VCR.use_cassette("townOk") do
      assert_difference('Town.count') do
        post :create, town: { name: @town.name }
      end
      assert_redirected_to town_path(assigns(:town))
    end
  end
  
 test "shouldnt create town" do
    VCR.use_cassette("townInexisting") do
      assert_no_difference('Town.count') do
        post :create, town: { name: @inexisting.name }
      end
      assert_response :success
    end
  end

  test "should show town" do
    VCR.use_cassette("showTown") do
      get :show, id: @town
      assert_response :success
    end
  end
  
  test "should get edit" do
    get :edit, id: @town
    assert_response :success
  end
  
  test "should update town" do
    VCR.use_cassette("townOk") do
      patch :update, id: @town, town: { latitude: @town.latitude, longitude: @town.longitude, name: @town.name }
      assert_redirected_to town_path(assigns(:town))
    end
  end
  
  test "should destroy town" do
    assert_difference('Town.count', -1) do
      delete :destroy, id: @town
    end

    assert_redirected_to towns_path
  end
end