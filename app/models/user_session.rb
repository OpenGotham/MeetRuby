class UserSession < Authlogic::Session::Base
  def self.oauth_consumer
       OAuth::Consumer.new("ABDAE5ED0962D3332A0B546174997828", "856263601BB15FA05D1062AA082FF6CD",
       { :site=>"http://www.meetup.com",
         :request_token_path => "/oauth/request/", 
         :authorize_url => "/authorize/",
         :access_token_url =>"/oauth/access/" })
  end
    
end