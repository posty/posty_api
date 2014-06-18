require 'spec_helper'

describe Posty::API do
  include Rack::Test::Methods

  def app
    Posty::API
  end
  
  api_key = ApiKey.active.first || ApiKey.create
  
  before(:each) do
    header 'AUTH_TOKEN', ApiKey.active.first.access_token
  end
  
  shared_examples "transports" do
    describe "GET /api/v1/transports" do
      it "returns all transports" do
        get "/api/v1/transports"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end
    
    describe "POST /api/v1/transports name='test.de' destination='smtp:[localhost]'" do
      it "creates the transport test.de" do
        post "/api/v1/transports", {"name" => "test.de", "destination" => "smtp:[localhost]"}
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)["virtual_transport"]).to include("name" => "test.de")
      end
    end
    
    describe "PUT /api/v1/transports/test.de name='example.com'" do
      it "changes the transport name from test.de to example.com" do
        put "/api/v1/transports/test.de", {"name" => "example.com"}
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_transport"]).to include("name" => "example.com")
      end
    end
  
    describe "DELETE /api/v1/transports/example.com" do
      it "delete the transport example.com" do
        delete "/api/v1/transports/example.com"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_transport"]).to include("name" => "example.com")
      end
    end
  end    

  shared_examples "users" do
    describe "GET /api/v1/domains/test.de/users" do
      it "returns all users for the domain test.de" do
        get "/api/v1/domains/test.de/users"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end
    
    describe "POST /api/v1/domains/test.de/users name='test@test.de' password='tester', quota='1000000'" do
      it "creates the user test@test.de" do
        post "/api/v1/domains/test.de/users", {"name" => "test", "password" => "tester", "quota" => 1000000}
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)["virtual_user"]).to include("name" => "test")
      end
    end
    
    describe "PUT /api/v1/domains/test.de/users/test name='posty@test.de'" do
      it "changes the user name from test@test.de to posty@test.de" do
        put "/api/v1/domains/test.de/users/test", {"name" => "posty"}
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_user"]).to include("name" => "posty")
      end
    end
  
    describe "DELETE /api/v1/domains/test.de/users/posty" do
      it "delete the user posty@test.de" do
        delete "/api/v1/domains/test.de/users/posty"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_user"]).to include("name" => "posty")
      end
    end
  end
  
  shared_examples "domain_aliases" do
    describe "GET /api/v1/domains/test.de/aliases" do
      it "returns all domain aliases for the domain test.de" do
        get "/api/v1/domains/test.de/aliases"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end
    
    describe "POST /api/v1/domains/test.de/aliases name='tester.de'" do
      it "creates the domain alias tester.de" do
        post "/api/v1/domains/test.de/aliases", {"name" => "tester.de"}
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)["virtual_domain_alias"]).to include("name" => "tester.de")
      end
    end
    
    describe "PUT /api/v1/domains/test.de/aliases/tester.de name='tester2.de'" do
      it "changes the domain alias name from tester.de to tester2.de" do
        put "/api/v1/domains/test.de/aliases/tester.de", {"name" => "tester2.de"}
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_domain_alias"]).to include("name" => "tester2.de")
      end
    end
  
    describe "DELETE /api/v1/domains/test.de/aliases/tester2.de" do
      it "delete the domain alias tester2.de" do
        delete "/api/v1/domains/test.de/aliases/tester2.de"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_domain_alias"]).to include("name" => "tester2.de")
      end
    end
  end

  shared_examples "user_aliases" do
    describe "POST /api/v1/domains/test.de/users name='destination@test.de' password='tester' quota=10000" do
      it "creates the user destination@test.de" do
        post "/api/v1/domains/test.de/users", {"name" => "destination", "password" => "tester", "quota" => 10000}
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)["virtual_user"]).to include("name" => "destination")
      end
    end

    describe "GET /api/v1/domains/test.de/users/destination/aliases" do
      it "returns all aliases for the user destination@test.de" do
        get "/api/v1/domains/test.de/users/destination/aliases"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end
    
    describe "POST /api/v1/domains/test.de/users/destination/aliases name='newalias'" do
      it "creates the user alias newalias@test.de" do
        post "/api/v1/domains/test.de/users/destination/aliases", {"name" => "newalias"}
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)["virtual_user_alias"]).to include("name" => "newalias")
      end
    end
    
    describe "PUT /api/v1/domains/test.de/users/destination/aliases/newalias name='newalias'" do
      it "changes the user alias name from newalias@test.de to newalias2@test.de" do
        put "/api/v1/domains/test.de/users/destination/aliases/newalias", {"name" => "newalias2"}
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_user_alias"]).to include("name" => "newalias2")
      end
    end
  
    describe "DELETE /api/v1/domains/test.de/users/destination/aliases/newalias2" do
      it "delete the user alias newalias2@test.de" do
        delete "/api/v1/domains/test.de/users/destination/aliases/newalias2"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_user_alias"]).to include("name" => "newalias2")
      end
    end
  end

  describe Posty::API do
    describe "GET /api/v1/domains" do
      it "returns all domains" do
        get "/api/v1/domains"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end
  
    describe "POST /api/v1/domains name='test.de'" do
      it "creates the domain test.de" do
        post "/api/v1/domains", {"name" => "test.de"}
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)["virtual_domain"]).to include("name" => "test.de")
      end
    end
    
    include_examples "users"
    include_examples "domain_aliases"
    include_examples "user_aliases"
    include_examples "transports"

    describe "POST /api/v1/domains name='test.de'" do
      it "creates the domain test.de" do
        post "/api/v1/domains", {"name" => "test.de"}
        expect(last_response.status).to eq(400)
        expect(JSON.parse(last_response.body)["error"]).to include("name" => ["has already been taken"])
      end
    end
        
    describe "PUT /api/v1/domains/test.de name='posty-soft.de'" do
      it "changes the domain name from test.de to posty-soft.de" do
        put "/api/v1/domains/test.de", {"name" => "posty-soft.de"}
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_domain"]).to include("name" => "posty-soft.de")
      end
    end
  
    describe "DELETE /api/v1/domains/posty-soft.de" do
      it "delete the domain posty-soft.de" do
        delete "/api/v1/domains/posty-soft.de"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)["virtual_domain"]).to include("name" => "posty-soft.de")
      end
    end
  end
end