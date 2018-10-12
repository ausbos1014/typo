require 'spec_helper'

describe Admin::CategoriesController do
  render_views

  before(:each) do
    Factory(:blog)
    #TODO Delete after removing fixtures
    Profile.delete_all
    henri = Factory(:user, :login => 'henri', :profile => Factory(:profile_admin, :label => Profile::ADMIN))
    request.session = { :user => henri.id }
  end

  describe "Load new categories page" do
    it "should successfully load a new categories page when params is empty" do
      category_page = Factory(:category)
      Category.should_receive(:find).with(:all).and_return([])
      Category.should_receive(:new).and_return(category_page)
      post :edit, 'category' => { :name => "Atlas Shrugged" }

      expect(response).to render_template(category_page)
      
    end
    
    it "should post categories" do
      post :edit, 'category' => { :name => "The Fountainhead" }
      assigns(:category).should_not be_nil
      
    end 
    
#    it "should delete categories" do
#      @category = Category.create!(:name => "We the Living")
#      get :destroy, :id => @category.id
#      expect(assigns(:category)).to be_nil
#    end    
    
  end



  it "test_index" do
    get :index
    assert_response :redirect, :action => 'index'
  end

  describe "test_edit" do
    before(:each) do
      get :edit, :id => Factory(:category).id
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have valid category' do
      assigns(:category).should_not be_nil
      assert assigns(:category).valid?
      assigns(:categories).should_not be_nil
    end
  end

  it "test_update" do
    post :edit, :id => Factory(:category).id
    assert_response :redirect, :action => 'index'
  end

  describe "test_destroy with GET" do
    before(:each) do
      test_id = Factory(:category).id
      assert_not_nil Category.find(test_id)
      get :destroy, :id => test_id
    end

    it 'should render destroy template' do
      assert_response :success
      assert_template 'destroy'      
    end
  end

  it "test_destroy with POST" do
    test_id = Factory(:category).id
    assert_not_nil Category.find(test_id)
    get :destroy, :id => test_id

    post :destroy, :id => test_id
    assert_response :redirect, :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(test_id) }
  end
  
end
