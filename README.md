# OAuth2 provider
App that generates access token for existing user.

Used gems: [doorkeeper gem](https://github.com/applicake/doorkeeper), [devise](https://github.com/plataformatec/devise), [doorkeeper-jwt](https://github.com/chriswarren/doorkeeper-jwt)
## Setup 
```
https://github.com/DashaGerasimova/oauth2_provider.git
cd oauth2_provider

# install dependencies
bundle install

# Setup database
rails db:setup

# Set secret word
export SECRET_OAUTH_KEY=some_secret_word

# Sign up user and create application
http://localhost:3001/oauth/applications/new
```
## Get token
To get token send POST request with user credentials:
```
curl -X POST -d "grant_type=password&email=some_user_email&password=some_user_password&client_id=your-client-id" localhost:3001/oauth/token
```

Or using Net::HTTP class:
```
require 'net/http'

request_params = {
  :client_id => client_id,
  :grant_type => 'password',
  :email => email,
  :password => password
}
uri = URI.parse(service_uri)
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri + "/oauth/token")
request.body = request_params.to_query
response = http.request(request)

JSON.parse(response.body)
```

You should recieve this response:
```
{"access_token": ...,
"token_type":"bearer",
"expires_in":7200,
"refresh_token": ...,
"scope": ...,
"created_at": ...}
```
