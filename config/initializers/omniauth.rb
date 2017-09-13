OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '294242504392568', '7c3dfcfb1ebffb4cc603a2009859e4a1', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end