require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "ZFLq6sfW63Th6GiWeRK4",
      password_confirmation: "ZFLq6sfW63Th6GiWeRK4",
      auth0_id: "auth0|eZYiQ6A6Fi42PCEbJN3N",
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = [
      'user@example,com',
      'user@example..com',
      'user_at_foo.org',
      'user.name@example.',
      'foo@bar_baz.com',
      'foo@bar baz.com',
      'foo@bar+baz.com]'
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "auth0_id should be unique" do
    duplicate_user = @user.dup
    duplicate_user.auth0_id = @user.auth0_id.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
