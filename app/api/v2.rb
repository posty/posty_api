module Posty
  class API_v2 < Grape::API
    version 'v2', :using => :path, :vendor => 'posty'
    
    desc "Returns zong."
    get :zing do
      {:environment => ENV['RACK_ENV'], :routes => Posty::API::routes}
    end
  end
end