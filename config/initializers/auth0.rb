Rails.application.config.middleware.use OmniAuth::Builder do

  # TODO: store these in ENV
  provider(
    :auth0,
    'tcuv7t39K1AbmLK4OEpJAdAfYLeEMgJF',
    'y6DB0mOwJIaURVhF5xRA4oqh4_N-leN8N80XmjEXm_N_H27tppsB_eBkRwAzlsIG',
    'joshc-test.auth0.com',
    callback_path: "/auth/auth0/callback",
    authorize_params: {
      scope: 'openid profile email',
      audience: 'https://joshc-test.auth0.com/userinfo'
    }
  )
end
