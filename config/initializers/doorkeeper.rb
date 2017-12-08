Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  # resource_owner_authenticator do
  #   current_user || redirect_to(new_user_session_url)
  # end

  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end

  # admin_authenticator do
  #   current_user || redirect_to(new_user_session_url)
  #   # Put your admin authentication logic here.
  #   # Example implementation:
  #   # Admin.find_by_id(session[:admin_id]) || redirect_to(new_admin_session_url)
  # end

  # Authorization Code expiration time (default 10 minutes).
  # authorization_code_expires_in 10.minutes

  access_token_generator "::Doorkeeper::JWT"

  # Access token expiration time (default 2 hours).
  # If you want to disable expiration, set this to nil.
  # access_token_expires_in 2.hours
  # reuse_access_token

  # Issue access tokens with refresh token (disabled by default)
  use_refresh_token

  default_scopes :public
  # optional_scopes :write, :update

  # client_credentials :from_basic, :from_params
  # access_token_methods :from_bearer_authorization, :from_access_token_param, :from_bearer_param

  # native_redirect_uri 'urn:ietf:wg:oauth:2.0:oob'

  grant_flows %w[password]

  skip_authorization do
    true
  end
end

Doorkeeper::JWT.configure do
  # Set the payload for the JWT token. This should contain unique information
  # about the user.
  # Defaults to a randomly generated token in a hash
  # { token: "RANDOM-TOKEN" }
  token_payload do |opts|
    user = User.find(opts[:resource_owner_id])
    {
      user: {
        id: user.id,
        email: user.email
      },
      # iss: ENV["API_HOST"],
      jti: SecureRandom.uuid,
      exp: (opts[:created_at] + opts[:expires_in]).utc.to_i,
      iat: opts[:created_at].utc.to_i,
      sub: user.id
    }
  end

  # Optionally set additional headers for the JWT. See https://tools.ietf.org/html/rfc7515#section-4.1
  token_headers do |opts|
    {
      kid: opts[:application][:uid]
    }
  end

  # Use the application secret specified in the Access Grant token
  # Defaults to false
  # If you specify `use_application_secret true`, both secret_key and secret_key_path will be ignored
  use_application_secret false

  # Set the encryption secret. This would be shared with any other applications
  # that should be able to read the payload of the token.
  # Defaults to "secret"
  secret_key ENV["SECRET_OAUTH_KEY"]

  # If you want to use RS* encoding specify the path to the RSA key
  # to use for signing.
  # If you specify a secret_key_path it will be used instead of secret_key
  # secret_key_path "path/to/file.pem"

  # Specify encryption type. Supports any algorithim in
  # https://github.com/progrium/ruby-jwt
  # defaults to nil
  encryption_method :hs512
end
