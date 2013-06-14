require 'grape-swagger'

module Posty
  class API < Grape::API
    prefix 'api'
    format :json
    rescue_from :all

    helpers APIHelper
    
    mount ::Posty::API_v1
    mount ::Posty::API_v2
    
    add_swagger_documentation :api_version => "v1"
  end
end