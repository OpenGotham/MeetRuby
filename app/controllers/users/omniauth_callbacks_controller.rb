class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing(provider)
      logger.error("in method_missing of provider #{provider.to_yaml}")
      if !User.omniauth_providers.index(provider).nil?
        #omniauth = request.env["omniauth.auth"]
        omniauth = env["omniauth.auth"]
        logger.error("env['omniauth.auth'] #{omniauth.to_yaml}")
        if current_user #or User.find_by_email(auth.recursive_find_by_key("email"))
          current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid']||omniauth['member_id'])
           flash[:notice] = "Authentication successful"
           redirect_to edit_user_registration_path
        else

          authentication = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid']||omniauth['member_id'])
          
          if authentication
            logger.error("authentication  #{authentication.to_yaml}")
            logger.error("omniauth  #{omniauth.to_yaml}")
            
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            sign_in_and_redirect(:user, authentication.user)
            #sign_in_and_redirect(authentication.user, :event => :authentication)
          else

            #create a new user
            unless omniauth.recursive_find_by_key("email").blank?
              user = User.find_or_initialize_by_email(:email => omniauth.recursive_find_by_key("email"))
            else
              user = User.new
            end

            # user.apply_omniauth(omniauth)
            #user.confirm! #unless user.email.blank?

            if user.save
              flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider'] 
              sign_in_and_redirect(:user, user)
            else
              session[:omniauth] = omniauth.except('extra')
              redirect_to new_user_registration_url
            end
          end
        end
      end
    end
  
  # # def github
  #   #   
  #   #   
  #   #     logger.info("in github of callback controller")
  #   #     # You need to implement the method below in your model
  #   #     @user = User.find_for_github_oauth(env["omniauth.auth"], current_user)
  #   #     
  #   #     if @user.persisted?
  #   #       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
  #   #       logger.info("**user success: ")
  #   #       sign_in_and_redirect @user, :event => :authentication
  #   #     else
  #   #       logger.info("**user failure: #{env["omniauth.auth"]}")
  #   #       session["devise.facebook_data"] = env["omniauth.auth"]
  #   #       redirect_to new_user_registration_url
  #   #     end
  #   #   end
  #     def meetup
  #       logger.error("in meetup of callback controller")
  #       data = env["omniauth.auth"]
  #       @user = User.find_for_meetup_oauth(data, current_user)
  #       if @user.persisted?
  #             flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
  #             logger.info("**user success: #{@user.to_yaml}")
  #             sign_in_and_redirect @user, :event => :authentication
  #           else
  #             logger.info("**user failure: #{env["omniauth.auth"]}")
  #             session["devise.meetup_data"] = env["omniauth.auth"]
  #             redirect_to new_user_registration_url
  #           end
  #       # session["devise.github_data"] = data["extra"]["user_hash"]
  #       # render :json => data
  #     end
  #   
  #   
  #     def github
  #      
  #       logger.error("in github of callback controller")
  #       data = env["omniauth.auth"]
  #       @user = User.find_for_github_oauth(data, current_user)
  #       if @user.persisted?
  #             flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
  #             logger.info("**user success: #{@user.to_yaml}")
  #             sign_in_and_redirect @user, :event => :authentication
  #           else
  #             logger.info("**user failure: #{env["omniauth.auth"]}")
  #             session["devise.github_data"] = env["omniauth.auth"]
  #             redirect_to new_user_registration_url
  #           end
  #       # session["devise.github_data"] = data["extra"]["user_hash"]
  #       # render :json => data
  #     end
  #     def failure
  #       logger.error("in failure of #{resource_name} callback controller for #{failed_strategy.name.to_s.humanize} due to #{failure_message}")
  #       logger.error("omniauth auth #{env["omniauth.auth"]}")
  #       set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
  #       redirect_to after_omniauth_failure_path_for(resource_name)
  #     end
end