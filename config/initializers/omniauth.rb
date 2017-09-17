Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['33251279595-0o1pf7vtv2rdn0ga9t1o03be1fima6nq.apps.googleusercontent.com'], ENV['0TicTBtj1M-0O-vEMj6qKuZ-']
end