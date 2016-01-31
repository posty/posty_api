module Posty
  # rubocop:disable ClassAndModuleCamelCase
  class API_v1 < Grape::API
    version 'v1', using: :path, vendor: 'posty'
    before { authenticate! }

    resource :api_keys do
      desc 'Returns all available API Keys'
      get do
        ApiKey.all
      end

      desc 'Creates a new API Key'
      post do
        ApiKey.create(attributes_for_keys([:expires_at]))
      end

      segment '/:api_key' do
        desc 'Returns the information to the specified api_key'
        get do
          current_api_key
        end

        desc 'Update the specified api_key'
        put do
          return_on_success(current_api_key) do |api_key|
            api_key.update_attributes(attributes_for_keys([:active, :expires_at]))
          end
        end

        desc 'Delete the given token'
        delete do
          current_api_key.destroy
        end
      end
    end

    resource :summary do
      desc 'Returns a summary of all Resources'
      get do
        get_summary
      end
    end

    resource :transports do
      desc 'Returns all available transports'
      get do
        VirtualTransport.all
      end

      desc 'Create new transport'
      post do
        @transport = VirtualTransport.new(attributes_for_keys([:name, :destination]))
        @transport.save ? @transport : validation_error(@transport.errors)
      end

      segment '/:transport_name', requirements: { transport_name: /([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/ } do
        desc 'Returns the information to the specified transport'
        get do
          current_transport
        end

        desc 'Update the specified transport'
        put do
          return_on_success(current_transport) do |transport|
            transport.update_attributes(attributes_for_keys([:name, :destination]))
          end
        end

        desc 'Delete the specified transport'
        delete do
          current_transport.destroy
        end
      end
    end

    resource :domains do
      desc 'Returns all available domains'
      get do
        VirtualDomain.all
      end

      desc 'Create new domain'
      post do
        @domain = VirtualDomain.new(attributes_for_keys([:name]))
        @domain.save ? @domain : validation_error(@domain.errors)
      end

      segment '/:domain_name', requirements: { domain_name: /([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/ } do
        desc 'Returns the information to the specified domain'
        get do
          current_domain
        end

        desc 'Update the specified domain'
        put do
          return_on_success(current_domain) do |domain|
            domain.update_attributes(attributes_for_keys([:name]))
          end
        end

        desc 'Delete the specified domain'
        delete do
          current_domain.destroy
        end

        resource '/users' do
          desc 'Returns all users for the specified domain'
          get do
            current_domain.virtual_users
          end

          desc 'Create new user'
          post do
            @user = VirtualUser.new(current_domain_id_hash.merge(attributes_for_keys([:name, :password, :quota])))
            @user.save ? @user : validation_error(@user.errors)
          end

          segment '/:user_name', requirements: { user_name: /[a-z0-9\-\.]+/ } do
            desc 'Returns the information to the specified user'
            get do
              current_user
            end

            desc 'Update the specified user'
            put do
              return_on_success(current_user) do |user|
                user.update_attributes(attributes_for_keys([:name, :password, :quota]))
              end
            end

            desc 'Delete the specified user'
            delete do
              current_user.destroy
            end

            resource '/aliases' do
              desc 'Returns all aliases for the specified user'
              get do
                current_user.virtual_user_aliases
              end

              desc 'Create new user alias'
              post do
                @alias = VirtualUserAlias.new(current_user_id_hash.merge(attributes_for_keys([:name])))
                @alias.save ? @alias : validation_error(@alias.errors)
              end

              segment '/:alias_name', requirements: { alias_name: /[a-z0-9\-\.]+/ } do
                desc 'Returns the information to the specified user alias'
                get do
                  current_user_alias
                end

                desc 'Update the specified user alias'
                put do
                  return_on_success(current_user_alias) do |user_alias|
                    user_alias.update_attributes(attributes_for_keys([:name]))
                  end
                end

                desc 'Delete the specified user alias'
                delete do
                  current_user_alias.destroy
                end
              end
            end
          end
        end

        resource '/aliases' do
          desc 'Returns all aliases for the specified domain'
          get do
            current_domain.virtual_domain_aliases
          end

          desc 'Create new domain alias'
          post do
            @alias = VirtualDomainAlias.new(current_domain_id_hash.merge(attributes_for_keys([:name])))
            @alias.save ? @alias : validation_error(@alias.errors)
          end

          segment '/:alias_name', requirements: { alias_name: /([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}/ } do
            desc 'Returns the information to the specified domain alias'
            get do
              current_domain_alias
            end

            desc 'Update the specified domain alias'
            put do
              return_on_success(current_domain_alias) do |domain_alias|
                domain_alias.update_attributes(attributes_for_keys([:name]))
              end
            end

            desc 'Delete the specified domain alias'
            delete do
              current_domain_alias.destroy
            end
          end
        end
      end
    end
  end
end
