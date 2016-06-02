require 'sinatra'
require './database'

class DatabaseServer < Sinatra::Base
  configure do
    set :db, Database.new('database.txt')
  end

  get '/set' do
    write(params)
    [200, "OK"]
  end

  get '/get' do
    begin
      read(params[:key])
    rescue KeyError
      [404, ["Key not found"]]
    end
  end

  def write(params)
    settings.db.merge!(params)
    File.open('database.txt', 'a+') do |f|
      params.each { |key, value| f.puts("#{key}, #{value}") }
    end
  end

  def read(key)
    settings.db.fetch(key)
  end

  run! if app_file == $0
end