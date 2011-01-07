class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def github
  #   
  #   
  #     logger.info("in github of callback controller")
  #     # You need to implement the method below in your model
  #     @user = User.find_for_github_oauth(env["omniauth.auth"], current_user)
  #     
  #     if @user.persisted?
  #       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
  #       logger.info("**user success: ")
  #       sign_in_and_redirect @user, :event => :authentication
  #     else
  #       logger.info("**user failure: #{env["omniauth.auth"]}")
  #       session["devise.facebook_data"] = env["omniauth.auth"]
  #       redirect_to new_user_registration_url
  #     end
  #   end
    def meetup
      
    end
  
  
    def github
     
      logger.error("in github of callback controller")
      data = env["omniauth.auth"]
      @user = User.find_for_github_oauth(data, current_user)
      if @user.persisted?
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
            logger.info("**user success: #{@user.to_yaml}")
            sign_in_and_redirect @user, :event => :authentication
          else
            logger.info("**user failure: #{env["omniauth.auth"]}")
            session["devise.facebook_data"] = env["omniauth.auth"]
            redirect_to new_user_registration_url
          end
      # session["devise.github_data"] = data["extra"]["user_hash"]
      # render :json => data
    end
    def failure
      logger.error("in failure of #{resource_name} callback controller for #{failed_strategy.name.to_s.humanize} due to #{failure_message}")
      logger.error("omniauth auth #{env["omniauth.auth"]}")
      set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
      redirect_to after_omniauth_failure_path_for(resource_name)
    end
end