Rails.application.config.middleware.use OmniAuth::Builder do

  auth0_domain = ENV['AUTH0_RUBY_DOMAIN']
  provider(
    :auth0,
    ENV['AUTH0_RUBY_CLIENT_ID'],
    ENV['AUTH0_RUBY_CLIENT_SECRET'],
    auth0_domain,
    callback_path: "/auth/auth0/callback",
    authorize_params: {
      scope: 'openid profile email',
      audience: "https://#{auth0_domain}/userinfo"
    }
  )
end
