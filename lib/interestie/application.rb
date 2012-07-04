require "sinatra"
require "json"

require "yasarg"
Yasarg::Connection.establish

$LOAD_PATH.unshift File.expand_path("../../../app/models", __FILE__)
require "interest"

get "/" do
  interest = Interest.new(params[:interest])
  interest.save ? ok_response(params) : error_response(params)
end

def ok_response(params)
  respond_with(params)
end

def error_response(params)
  respond_with(params, {
    errors:["unable to set up interest"]
  })
end

def respond_with(params, json_data = {ok:"ok"})
  "#{params["callback"]}(#{json_data.to_json})"
end
