require 'json'

def lambda_handler(event:, context:)
    method = event['httpMethod']
    query_string = event['queryStringParameters'] || {}
    name = query_string['name'] || 'World'
    {
        statusCode: 200,
        body: JSON.generate({
            code: 42,
            message: "Hello, #{name}!",
            method: method,
            memory: context.memory_limit_in_mb
        })
    }
end
