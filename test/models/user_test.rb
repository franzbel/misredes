  require 'test_helper'

  class UserTest < ActiveSupport::TestCase
    def setup
      @user = User.new(:name=>"Franz Beltran", :email=>"fbm@gmail.com",
                       :password => "secreto", :password_confirmation => "secreto")
    end
    test "should be valid" do
      assert @user.valid?
    end
    test "name should be present" do
      @user.name = ""
      assert_not @user.valid?
    end
    test "email should be present" do
      @user.email = ""
      assert_not @user.valid?
    end
    test "name should not be to long" do
      @user.name = "a"*51
      assert_not @user.valid?
    end

    test "email should not be to long" do
      @user.email = "a"*244+"@example.com"
      assert_not @user.valid?
    end
    test "email validation should accept valid addresses" do
      valid_addresses = %w[FRANZ@foo.com FRANZ_BEL-MER@foo.bar.org franz.beltran@foo.co]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      end
    end
    test"email validation should reject invalid addresses" do
      invalid_addresses = %w[FRANZ@foo,com FRANZ_BEL-MER_at_foo.bar.org franz.beltran@foo+bar.co]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end

    test "email should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      assert_not duplicate_user.valid?
    end

    test "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a"*5
      assert_not @user.valid?
    end

    test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 6
      assert_not @user.valid?
    end
  end
