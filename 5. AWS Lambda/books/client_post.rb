require 'json'
require 'faraday'

URL = 'https://ito42rbwd3.execute-api.us-west-2.amazonaws.com/default/books'

body = {
  "Author" => "Suzzane Collins",
  "Title" => "Mockingjay",
  "Year" => 2010,
  "Note" => "Last book of the Hunger Games trilogy"
}

connection = Faraday.new(url: URL)
response = connection.post do |req|
  req.body = JSON.dump(body)
end

puts response.status
p response.body