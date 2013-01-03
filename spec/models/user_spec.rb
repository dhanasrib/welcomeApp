# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com", :password => "dhanasri", :password_confirmation => "dhanasri"}
  end
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name=>""))
    no_name_user.should_not be_valid
  end
  it "should require an email address" do
     no_email_user = User.new(@attr.merge(:email => ""))
     no_email_user.should_not be_valid
  end
  it "should require a password" do
    no_pwd_user = User.new(@attr.merge(:password =>"",:password_confirmation => ""))
    no_pwd_user.should_not be_valid
  end
  it "should require a matching confirmation password" do
    wrng_cnf_pwd_user = User.new(@attr.merge(:password_confirmation => "invalid"))
    wrng_cnf_pwd_user.should_not be_valid
  end
  it "should have minimum length password" do
    shrt_pwd_user = User.new(@attr.merge(:password => "aaaaa",:password_confirmation => "aaaaa"))
    shrt_pwd_user.should_not be_valid
  end
  it "password should not exceed maximum length" do
    lng_pwd_user = User.new(@attr.merge(:password => "a"*41,:password_confirmation => "a"*41))
    lng_pwd_user.should_not be_valid
  end
  it "should reject names that are too long" do
    long_user_name  =  "a"*51
    long_name_user = User.new(@attr.merge(:name=>long_user_name))
    long_name_user.should_not be_valid
  end
  it "should accept valid email addresses" do
     addresses =  %w[test@gmail.com dhana@valuelabs.net fhjj.fjhf_tufj@jhfj.com]
     addresses.each do |a|
       valid_email_user =  User.new(@attr.merge(:email => a))
       valid_email_user.should be_valid
     end
  end
  it "should reject invalid email addresses" do 
   addresses = %w[test@gmail,com dhana-valuelabs.net fhjj.fjhf_tufj@jhfj.]
   addresses.each do |a|
     invalid_email_user = User.new(@attr.merge(:email => a))
     invalid_email_user.should_not be_valid
   end
  end
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    dup_user = User.new(@attr.merge(:email=>@attr[:email].upcase))
    dup_user.should_not be_valid
  end
  
  
  describe "password_encryption" do
  before(:each) do
    @user = User.create!(@attr)
  end
  it "should have an encrypted password attribute" do
    @user.should respond_to(:encrypted_password)
  end
  describe "has_password? method" do
    it "should be true if the passwords match" do
    @user.has_password?(@attr[:password]).should be_true
    end
  end
  end  
end
