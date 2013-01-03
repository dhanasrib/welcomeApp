require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    #it "should have Registration title" do
     # get :new
      #response.should have_selector("title", :content => "Snapfish - Registration")
    #end
  end
  
describe "POST 'create'" do
  describe "failure" do
     before(:each) do
       @attr = {:name => "", :email=> "", :password => "", :password_confirmation => ""}
     end  
     it "should not create a user" do
        lambda do
          post:create, :user => @attr
         end.should_not change(User,:count) 
     end
     #it "should have the right title" do
      #    post:create, :user => @attr
       #   response.should have_selector("title", :content => "Snapfish - Registration")
     #end
     it "should render the new page" do
       post:create, :user => @attr
       response.should render_template('new')
     end     
  end  
  
  describe "success" do
    before (:each)  do
      @attr = {:name => "New User",:email => "new.user@example.com", :password => "testpwd", :password_confirmation => "testpwd"}
    end
    it "should create a user"  do
      lambda do 
        post:create, :user => @attr
      end.should change(User, :count).by(1)
    end
    it "should redirect to user show page" do
      post:create, :user => @attr
      response.should redirect_to(user_path(assigns(:user)))
    end
  end
end  
  
  describe "GET 'show'" do
    before(:each) do
     @user = Factory(:user)
    end
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    it "should find the right user" do
       get :show, :id => @user
       assigns(:user).should == @user
    end
  end
end