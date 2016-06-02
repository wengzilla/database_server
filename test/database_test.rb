require File.expand_path "../test_helper.rb", __FILE__

class DatabaseTest < MiniTest::Test
  def test_initialize
    Database.any_instance.expects(:load_database).with("file.txt")
    Database.new("file.txt")
  end

  def test_load_database
    File.expects(:exist?).with("file.txt").returns(false)
    assert_equal Hash.new, Database.new("file.txt").data
  end

  def test_write
    db = Database.new("file.txt")
    db.write({"foo" => "bar"})
    assert_equal({"foo" => "bar"}, db.data)
  end

  def test_write_file
    File.any_instance.expects(:puts).with("foo, bar")
    Database.any_instance.stubs(:load_database).returns({})
    db = Database.new("file.txt")
    db.write({"foo" => "bar"})
  end

  def test_read
    db = Database.new("file.txt")
    db.stubs(:data).returns({"bar" => "baz"})
    assert_equal "baz", db.read("bar")
  end
end