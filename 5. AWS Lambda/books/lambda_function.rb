require 'json'
require 'aws-sdk-dynamodb'

DYNAMODB = Aws::DynamoDB::Client.new
TABLE_NAME = 'Books'

def make_response(status, body)
  {
    statusCode: status,
    body: JSON.generate(body)
  }
end

def handle_bad_method(method)
  make_response(405, {message: "Method not supported: #{method}"})
end

def make_result_list(items)
  items.map do |item| {
      'Author' => item['Author'],
      'Title' => item['Title'],
      'Year' => item['Year'].to_i,
      'Note' => item['Note']
    }
  end
end

def sort_items(items)
  items.sort! {|a, b| a['Year'] <=> b['Year']}
  items.sort! {|a, b| a['Author'] <=> b['Author']}
end

def get_books
  items = DYNAMODB.scan(table_name: TABLE_NAME).items
  sort_items(items)
  make_result_list(items)
end

def handle_get
  make_response(200, get_books)
end

def parse_body(body)
  if body
    begin
      data = JSON.parse(body)
      if data.key?('Author') and data.key?('Title')
        data
      else
        nil
      end
    rescue JSON::ParseError
      nil
    end
  else
    nil
  end
end

def store_book_item(body)
  data = parse_body(body)
  if data
    DYNAMODB.put_item({
      table_name: TABLE_NAME,
      item: data
    })
    true
  else
    false
  end
end

def handle_post
  make_response(201, 'New resource created')
end

def handle_bad_request
  make_response(400, 'Bad request (invalid input)')
end

def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'GET'
    handle_get
  elsif method == 'POST'
    if store_book_item(event['body'])
      handle_post
    else
      handle_bad_request
    end
  else
    handle_bad_method(method)
  end
end
