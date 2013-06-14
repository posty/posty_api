module Posty
  class API_v1 < Grape::API
    version 'v1', :using => :path, :vendor => 'posty'
    
    resource :domains do

      desc "Returns all available domains"
      get do
        VirtualDomain.all
      end
      
      desc "Create new domain"
      post do
        @domain = VirtualDomain.new(attributes_for_keys [ :name ])
        @domain.save ? @domain : validation_error(@domain.errors)
      end
      
      segment '/:domain_name', requirements: {domain_name: /[a-z0-9\-]{2,}\.[a-z0-9]{2,}/} do 
        desc "Returns the information to the specified domain"
        get do
          current_domain
        end
      
        desc "Update the specified domain"
        put do
          return_on_success(current_domain) do |domain|
            domain.update_attributes(attributes_for_keys [ :name ])
          end
        end
      
        desc "Delete the specified domain"
        delete do
          current_domain.destroy
        end
        
        resource '/users' do
          desc "Returns all users for the specified domain"
          get do
            current_domain.virtual_users
          end

          desc "Create new user"
          post do
            @user = VirtualUser.new(current_domain_id_hash.merge(attributes_for_keys [ :name, :password ]))
            @user.save ? @user : validation_error(@user.errors)
          end
      
          segment '/:user_name', requirements: {user_name: /[a-z0-9\-\.]+/} do
            desc "Returns the information to the specified user"
            get do
              current_user
            end
            
            desc "Update the specified user"
            put do
              return_on_success(current_user) do |user|
                user.update_attributes(attributes_for_keys [ :name, :password ])
              end
            end
      
            desc "Delete the specified user"
            delete do
              current_user.destroy
            end
          end
        end
        
        resource '/aliases' do
          desc "Returns all aliases for the specified domain"
          get do
            current_domain.virtual_aliases
          end
          
          desc "Create new alias"
          post do
            @alias = VirtualAlias.new(current_domain_id_hash.merge(attributes_for_keys [ :source, :destination ]))
            @alias.save ? @alias : validation_error(@alias.errors)
          end
          
          segment '/:alias_name', requirements: {alias_name: /[a-z0-9\-\.]+/} do
            desc "Returns the information to the specified alias"
            get do
              current_alias
            end
      
      
            desc "Update the specified alias"
            put do
              return_on_success(current_alias) do |aliass|
                aliass.update_attributes(attributes_for_keys [ :source, :destination ])
              end
            end
      
            desc "Delete the specified alias"
            delete do
              current_alias.destroy
            end
          end                    
        end
      end
    end
  end
end