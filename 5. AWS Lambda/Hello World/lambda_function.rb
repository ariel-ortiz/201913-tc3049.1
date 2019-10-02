require 'json'

def lambda_handler(event:, context:)
    # TODO implement
    {
        statusCode: 200,
        body: JSON.generate({
            code: 42,
            message: 'Hello from Lambda!'
        })
    }
end
