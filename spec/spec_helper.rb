$LOAD_PATH.unshift File.expand_path('../../lib/', __FILE__)

require "interestie"
original_env = ENV["RACK_ENV"]
ENV["RACK_ENV"] = "test"
Interestie::Connection.establish

# depois de rodar specs, voltar env ao normal
