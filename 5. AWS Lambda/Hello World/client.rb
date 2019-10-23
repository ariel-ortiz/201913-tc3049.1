require 'json'
require 'faraday'

URL = 'https://9l7z0kuzs0.execute-api.us-west-2.amazonaws.com/default/hello_world'
API_KEY = 'p8sqXjf6rr8TlgYbmgTv59hzspTFyx1dySZCSpF3'

connection = Faraday.new(url: URL)
response = connection.get do |request|
  request.headers['x-api-key'] = API_KEY
  request.params['name'] = 'Joker'
end

if response.success?
  puts response.status
  data = JSON.parse(response.body)
  puts data
  p data['code']
  p data['message']
  p data['method']
  p data['memory'].to_i
end
