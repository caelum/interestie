require 'interestie/application'
require 'rspec'
require 'rack/test'

set :environment, :test

describe "Interestie!" do
  include Rack::Test::Methods
  def app; Sinatra::Application; end

  def email; "ricardo.valeriano@gmail.com"; end
  def item; "123"; end
  def callback; "omglol"; end

  def get_interest
    get "/", {
      "interest[email]" => email,
      "interest[item]"  => item,
      "callback"        => callback
    }
  end

  def get_error_interest
    ar = double(:ar)
    ar.stub(:save).and_return(false)

    Interest.stub(:new).and_return(ar)

    get "/", {"callback" => "omglol"}
  end

  it "returns a jsonp ok on success" do
    get_interest
    last_response.should be_ok
    last_response.body.should == "omglol({\"ok\":\"ok\"})"
  end

  it "returns a jsonp errors on failure" do
    get_error_interest
    last_response.should be_ok
    last_response.body.should == "omglol({\"errors\":[\"unable to set up interest\"]})"
  end

  it "adds a interestie" do
    get_interest
    last = Interest.last
    last.email.should == email
    last.item.should == item
  end
end
