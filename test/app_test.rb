require File.expand_path "../test_helper.rb", __FILE__

include Rack::Test::Methods

class DatabaseServerTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    DatabaseServer
  end

  def setup
    DatabaseServer.settings.db = Database.new("file.txt")
  end

  def test_set
    Database.any_instance.expects(:write).with({"key1" => "value1"})
    get "/set?key1=value1"
    assert_equal "OK", last_response.body
  end

  def test_get
    Database.any_instance.expects(:read).with("key3").returns("value3")
    get "/get?key=key3"
    assert_equal "value3", last_response.body
  end

  def test_get_no_key
    get "/get?key=key5"
    assert_equal "Key not found", last_response.body
    assert_equal 404, last_response.status
  end

  def test_set_multiple_keys
    Database.any_instance.expects(:write).with({"key1" => "value1", "key2" => "value2"})
    get "/set?key1=value1&key2=value2"
  end

  def test_set_persists_across_requests
    get "/set?key6=value6"
    get "/set?key7=value7"
    get "/get?key=key6"
    assert_equal "value6", last_response.body
    get "/get?key=key7"
    assert_equal "value7", last_response.body
  end
end