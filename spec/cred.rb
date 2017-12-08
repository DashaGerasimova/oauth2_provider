# Little helper for testing tokens
client_id = '2bfc86fcc644e64bea842a971fa6d19ea1c837de018cadffa711866fed6d47e1'
client_secret = '87a8d5fed8f3ca363efe63b430c0bcfbaf154306e945b55b0be6af905b2a2299'
redirect_uri = 'http://localhost:3000/'
site = 'http://localhost:3001/'
client = OAuth2::Client.new(client_id, client_secret, :site => site)
client.auth_code.authorize_url(:redirect_uri => redirect_uri)
token = client.auth_code.get_token(code, :redirect_uri => redirect_uri)

# Request to get access_token from your credentials
curl -X POST -d "grant_type=password&email=dashagera@gmail.com&password=123456&client_id=2bfc86fcc644e64bea842a971fa6d19ea1c837de018cadffa711866fed6d47e1" localhost:3001/oauth/token