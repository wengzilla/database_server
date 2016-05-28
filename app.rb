require 'sinatra'

database = {}

get '/set' do
  database = database.merge(params)
  [200, params.map { |k, v| "#{k} was set to #{v}\n" }]
end

get '/get' do
  begin
    database.fetch(params[:key])
  rescue KeyError
    [404, ["Key not found"]]
  end
end
