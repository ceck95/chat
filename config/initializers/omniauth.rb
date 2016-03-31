Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
    provider :facebook, '1712436025668941', 'd6ce37e8132019a80a6c1cb77e7ca515',
           scope: 'public_profile', display: 'page', image_size: 'square',  provider_ignores_state: true
    # token_params: { parse: :json }

end
