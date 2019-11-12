require 'aws-sdk-dynamodb'

dynamodb = Aws::DynamoDB::Client.new

dynamodb.put_item({
  table_name: 'Books',
  item: {
    'Author' => 'Andy Weir',
    'Title' => 'The Martian',
    'Year' => 2011
  }
})

puts 'Item has been put'
