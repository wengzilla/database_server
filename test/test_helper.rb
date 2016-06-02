ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__
require 'minitest/autorun'
require "mocha/mini_test"
require 'rack/test'

Minitest.after_run {
  File.delete("file.txt") if File.exists?("file.txt")
}