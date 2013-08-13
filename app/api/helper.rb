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
    
    def get_summary(entitys = ['VirtualDomains', 'VirtualUsers', 'VirtualUserAliases', 'VirtualDomainAliases'])
      summary = {}
      
      entitys.sort.each do |entity|
        summary[entity] = entity.classify.constantize.all.count
      end
      
      return summary
    end
    
    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_session
    end
 
    def current_session
      @current_session ||= ApiKey.find_by_access_token_and_active(params[:access_token], true)
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
    
    def current_transport
      ensure_entity('Transport') do
        VirtualTransport.find_by_source(params[:transport_name])
      end
    end
    
    def current_user_alias
      ensure_entity('UserAlias') do
        current_user.virtual_user_aliases.find_by_name(params[:alias_name])
      end
    end

    def current_domain_alias
      ensure_entity('DomainAlias') do
        current_domain.virtual_domain_aliases.find_by_name(params[:alias_name])
      end
    end
    
    def current_domain_id_hash
      {"virtual_domain_id" => current_domain.id}
    end
    
    def current_user_id_hash
      {"virtual_user_id" => current_user.id}
    end
    
    def complete_email_address(user, domain)
      user + "@" + domain
    end
    
    def validation_error(errors)
      error!(errors, 400)
    end
  end
end