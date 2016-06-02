require 'csv'

class Database
  attr_accessor :path, :data

  def initialize(path)
    @path = path
    @data ||= load_database(path)
  end

  def load_database(path)
    File.exist?(path) ? Hash[CSV.read(path)] : {}
  end

  def write(params)
    data.merge!(params)
    File.open(path, 'a+') do |f|
      params.each { |key, value| f.puts("#{key}, #{value}") }
    end
  end

  def read(key)
    data.fetch(key)
  end
end