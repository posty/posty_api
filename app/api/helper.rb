module Posty
  module APIHelper
    def attributes_for_keys(keys)
      attrs = {}
      keys.each do |key|
        attrs[key] = params[key] if params[key].present?
      end
      attrs
    end

    def ensure_entity(message='', &block)
      entity = block.call
      
      unless entity
        error!("unknown #{message}", 404)
      end
      
      entity
    end
    
    def return_on_success(entity, &block)
      success = block.call(entity)
      
      success ? entity : validation_error(entity.errors)
    end
    
    def current_domain
      @current_domain ||= ensure_entity('Domain') do
        VirtualDomain.find_by_name(params[:domain_name])
      end
    end
    
    def current_user
      ensure_entity('User') do
        current_domain.virtual_users.find_by_name(params[:user_name])
      end
    end
    
    def current_alias
      ensure_entity('Alias') do
        current_domain.virtual_aliases.find_by_source(params[:alias_name])
      end
    end
    
    def current_domain_id_hash
      {"virtual_domain_id" => current_domain.id}
    end
    
    def complete_email_address(user, domain)
      user + "@" + domain
    end
    
    def validation_error(errors)
      error!(errors, 400)
    end
  end
end