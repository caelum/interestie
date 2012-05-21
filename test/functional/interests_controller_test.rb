require 'test_helper'

class InterestsControllerTest < ActionController::TestCase
  test "should create an interest" do
    get :create, {interest: {email: "guilherme.silveira@caelum.com.br", item: "fj-11"}, callback: 'cb'}
    assert_equal response.body,  "cb({ ok : 'ok'});"
  end

  test "should complain if missing an email or item" do
    get :create, {interest: {email: "guilherme.silveira@caelum.com.br"}, callback: 'cb'}
    assert_equal response.body,  "cb({ errors : 'unable to set up interest' });"
    get :create, {interest: {item: "fj-11"}, callback: 'cb'}
    assert_equal response.body,  "cb({ errors : 'unable to set up interest' });"
  end

end
