module AuthRequestHelper
  #
  # pass the @env along with your request, eg:
  #
  # GET '/labels', {}, @env
  #
  def http_login
    @env ||= {}
    user = ENV['BASIC_AUTH_USER']
    pw = ENV['BASIC_AUTH_PASSWORD']
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end
