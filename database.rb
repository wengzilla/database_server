require 'csv'

class Database
  def initialize(path)
    @data ||= load_database(path)
  end

  def load_database(path)
    File.exist?(path) ? Hash[CSV.read(path)] : {}
  end

  def merge!(params)
    @data.merge!(params)
  end

  def fetch(key)
    @data.fetch(key)
  end
end