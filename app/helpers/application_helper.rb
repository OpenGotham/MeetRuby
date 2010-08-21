module ApplicationHelper
   def oauth_register_button(options = {})
      oauth_button('register_with_oauth', options)
    end
    
    def oauth_login_button(options = {})
      oauth_button('login_with_oauth', options)
    end

    def oauth_register_image_button(image, options = {})
      oauth_image_button('register_with_oauth', image, options)
    end
    
    def oauth_login_image_button(image, options = {})
      oauth_image_button('login_with_oauth', image, options)
    end
    def nav_select(name, url, id)
      url_match = current_page?(url)
      
      controller_match = (controller.controller_name == "profiles" && name == "Rubyists" ) || (controller.controller_name ==  name.downcase)
      
      
      state =  url_match || controller_match ? 'active' : 'default'
      # innerds = 
      content_tag(:li,link_to(content_tag(:div, name) ,  state == 'default' ? url : '#'), :id => id, :class => state+' ui-state-'+state+' ui-corner-all navigation-item')
      # content_tag(:a, :href => url, innerds)
     
      
    end
  private
    def oauth_button(name, options = {})
      "<input type='submit' value='#{options[:value]}' name='#{name}' id='user_submit' class='#{options[:class]}'/>"
    end

    def oauth_image_button(name, image, options = {})
      "<input type='image', src='#{image}' value='#{options[:value]}' name='#{name}' id='user_submit' class='#{options[:class]}'/>"
    end
end
