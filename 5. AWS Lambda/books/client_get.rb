require 'json'
require 'faraday'

URL = 'https://ito42rbwd3.execute-api.us-west-2.amazonaws.com/default/books'

connection = Faraday.new(url: URL)
response = connection.get

if response.success?
  puts response.status
  data = JSON.parse(response.body)
  p data
end
