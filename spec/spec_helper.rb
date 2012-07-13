require 'rspec'

$LOAD_PATH.unshift File.expand_path('../../lib/', __FILE__)
require "interestie"

ENV["RACK_ENV"] = "test"
Interestie::Connection.establish

# depois de rodar specs, voltar env ao normal
