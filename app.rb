require 'sinatra'
require './database'

class DatabaseServer < Sinatra::Base
  set :db, Database.new

  get '/set' do
    settings.db.merge!(params)
    [200, "OK"]
  end

  get '/get' do
    begin
      settings.db.fetch(params[:key])
    rescue KeyError
      [404, ["Key not found"]]
    end
  end
end