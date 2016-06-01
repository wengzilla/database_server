class Database
  def initialize
    @data = {}
  end

  def merge!(params)
    @data.merge!(params)
  end

  def fetch(key)
    @data.fetch(key)
  end
end