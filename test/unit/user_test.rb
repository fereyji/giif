require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  # TODO: Remove this fixtures
  fixtures :addresses, :people, :adscriptions, :user_adscriptions
  # /TODO
  
  should_require_attributes :login, :password, :email
  should_require_unique_attributes :login, :email

  should_belong_to :user_incharge
  should_have_one :person

  def setup
    @newuser = { :login => 'fernando', :email => 'usuario@mail.com', :password => 'lifeislife', :password_confirmation => 'lifeislife'}
  end

  test "Should verify the login length" do
    @user = User.new(@newuser)
    @user.login = ' ' * 10
    assert !@user.valid?

    @user.login = 'fere yji'
    assert !@user.valid?

    @user.login = 'BadLogin'
    assert !@user.valid?

    @user.login = 'a' * 31
    assert !@user.valid?

    @user.login = 'lo'
    assert !@user.valid?
 end

  test "Should verify the password length" do
    @user = User.new(@newuser)
    @user.password = '*' * 4
    assert !@user.valid?

    @user.password = '1' * 35
    assert !@user.valid?
  end
  
  test "Should encrypt your secret" do
    assert_equal '26a81243a061f05b38fec50ae303e6b018e6bdd0fa0891904b272e509103f4a7e9dfc68a13eea9114616bfdee045d83eed78123380a7f348633c543d3a46055b', User.encrypt('yoursecret', 'RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG,t')
  end

  test "Should authenticate users with valid data" do
    assert User.authenticate?('admin', 'maltiempo')
    assert User.authenticate?('fernando', 'maltiempo')
  end

  test "Should create new user" do
    @user = User.create({ :login => 'golem', :email => 'golem@example.com', :password => 'quire', :password_confirmation => 'quire' })
    assert_equal 'golem', @user.login
    assert_equal 'golem@example.com', @user.email
    assert_equal User.encrypt('quire', @user.salt), @user.password
    assert !@user.is_activated?
  end

  test "Should activate an user and should maintain the same password" do
    @user = User.find_by_login('fernando')
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
    @user.activate
    assert @user.is_activated?
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
  end

  test "Should desactivate users and should maintain the same password" do
    @user = User.find_by_login('fernando')
    assert @user.is_activated?
    @user.unactivate
    assert !@user.is_activated?
    assert_equal User.encrypt('maltiempo', @user.salt), @user.password
  end

  test "Should verify the current password returning nil" do
    @user = User.find(:first)
    @user.current_password = 'maltiempo'
    assert_equal nil, @user.send(:verify_current_password)
  end

  test "Should verify current password with an invalid password and return false" do
    @user = User.find(:first)
    @user.current_password = 'inutil'
    assert !@user.send(:verify_current_password)
  end
  
  # TODO: Move this tests to other unit testing file
  def test_phone
      @record = User.find(2)
      assert_equal '26-21-20-44', @record.phone
  end
  
  def test_adscription_name
    @record = User.find(2)
      assert_equal 'Física Teórica', @record.adscription_name
    end
  
    def test_user_incharge_fullname
      @record = User.find(3)
      assert_equal 'Reyes Jímenez Fernando',@record.user_incharge_fullname
    end
  # /TODO
end

