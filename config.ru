require File.expand_path('../config/environment', __FILE__)

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:put, :delete, :get, :post, :options]
  end
end

#file = File.new(File.expand_path("../log/#{ENV['RACK_ENV']}.log", __FILE__), 'a+')
#file.sync = true
#use Rack::CommonLogger, file

run Posty::API