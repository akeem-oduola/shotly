Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"]
end
OmniAuth.config.on_failure = proc do |env|
  SessionsController.action(:auth_failure).call(env)
end
