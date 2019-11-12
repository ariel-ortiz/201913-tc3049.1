require 'json'
require 'aws-sdk-dynamodb'

dynamodb = Aws::DynamoDB::Client.new

def make_response(status, body)
  {
    statusCode: status,
    body: JSON.generate(body)
  }
end

def handle_bad_method(method)
  make_response(405, {message: "Method not supported: #{method}"})
end

def handle_get(event)
  make_response(200, {message: 'All Ok!'})
end

def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'GET'
    handle_get(event)
  else
    handle_bad_method(method)
  end
end
