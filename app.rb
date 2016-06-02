require 'sinatra'
require './database'

class DatabaseServer < Sinatra::Base
  configure do
    set :db, Database.new('database.txt')
  end

  get '/set' do
    settings.db.write(params)
    [200, "OK"]
  end

  get '/get' do
    begin
      settings.db.read(params[:key])
    rescue KeyError
      [404, ["Key not found"]]
    end
  end

  run! if app_file == $0
end