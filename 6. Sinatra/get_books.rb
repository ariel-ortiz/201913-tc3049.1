require 'sinatra'
require 'json'
require 'faraday'

URL = 'https://ito42rbwd3.execute-api.us-west-2.amazonaws.com/default/books'

get '/' do
  connection = Faraday.new(url: URL)
  response = connection.get
  @books = JSON.parse(response.body)
  erb :my_info
end