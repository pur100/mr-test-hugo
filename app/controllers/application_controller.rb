class ApplicationController < ShopifyApp::AuthenticatedController
  protect_from_forgery with: :exception
  include Response
  # before_action :authenticate_user!
end
