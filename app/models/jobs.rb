module Jobs
  
  class TestJob
     attr_accessor :echo_text, :user_id
     def initialize(options)
       @user_id = options["user_id"] || options[:user_id]
       @echo_text = options["echo_text"] || options[:echo_text]
     end
     def perform(options = nil)
       
       # user = User.find(@user_id)
       
       logger ||= Rails && Rails.logger ? Rails.logger : Logger.new(STDOUT)
       logger.info "echo #{@echo_text ? @echo_text : 'no input'}"

       return true
     end
   end
   
   # class RequestProcessor
   #    
   #    # started with env QUEUE=requests INTERVAL=1 rake environment resque:work
   #    
   #    
   #    @queue = :requests
   # 
   #    APP = Rack::Builder.new do
   #      use Rails::Rack::Static
   #      use Rack::CommonLogger
   #      run ActionController::Dispatcher.new
   #    end
   # 
   #    RACK_BASE_REQUEST = {
   #      "PATH_INFO" => "/things",
   #      "QUERY_STRING" => "",
   #      "REQUEST_METHOD" => "GET",
   #      "SERVER_NAME" => "localhost",
   #      "SERVER_PORT" => "3000",
   #      "rack.errors" => STDERR,
   #      "rack.input" => StringIO.new(""),
   #      "rack.multiprocess" => true,
   #      "rack.multithread" => false,
   #      "rack.run_once" => false,
   #      "rack.url_scheme" => "http",
   #      "rack.version" => [1, 0],
   #    }
   #    def self.perform(hash)
   #      url = hash.delete("url")
   # 
   #      request = RACK_BASE_REQUEST.clone
   #      request["PATH_INFO"] = url
   #      response = APP.call(request)
   # 
   #      body = "" 
   #      response.last.each { |part| body << part }
   # 
   #      hash["body"] = URI.escape(body)
   #      cmd = "redis-cli rpush responses #{hash.to_json.inspect}" 
   #      system cmd
   #    end
   #  end
   
   class FetchParseJob
     attr_accessor :url, :target, :response_type
     def initialize(options)
       @url = options["url"] || options[:url]
        @target = options["target"] || options[:target]
        @response_type = options["response_type"] || options[:response_type]
       
     end
     def perform(options = nil)
        hydra = Typhoeus::Hydra.new
        req = Typhoeus::Request.new(url)
        req.on_complete do |response|
          case response_type
          when "json"
            ActiveSupport::JSON.decode(response.body) unless fetch_response.nil?
          when "xml" || "html"
            xml_parser(response.body) unless fetch_response.nil?
          else
            nil
          end
        end 
        hydra.queue(req)
        hydra.run
        resp = req.handled_response
     end
     def html_parser(fetch_response)
       @feed_content = Nokogiri::XML(fetch_response)# unless fetch_response.nil?
       
     end
     def xml_parser(fetch_response)
        if !fetch_response.blank?
          @feed_content = Nokogiri::XML(fetch_response)# unless fetch_response.nil?
          @feed_content.css('item').blank? ? @feed_content.css('entry') : @feed_content.css('item')
        end
     end
     def json_parser(fetch_response)
       ActiveSupport::JSON.decode(fetch_response.body) #unless fetch_response.nil?
      
     end
     def response_handler(items)
       items.each do |e|
         @source = Source.new( :title => e.css('title').text, :released => e.css('pubDate').blank? ? e.css('published').first.text : e.css('pubDate').text)
         e.css('enclosure')
         @source.topic_category_list = e.css('category').map{|c|c.text.blank? ? c.attr('term') : c.text }
         @post = Post.create({:source =>  @source, :content => e.css('content').text.blank? ? e.css('description').text : e.css('content').text, :author => e.css('author').text, :summary => e.css('description').blank? ? e.css('summary').text : e.css('description').text })
       end
     end
     
   end
   class MeetupApiJob
     attr_accessor :meetup_api_key, :meetup_api_version, :read_method, :filter_hash
     
     
     def initialize(options)
       
       @meetup_api_key = options["meetup_api_key"] || options[:meetup_api_key]
       @meetup_api_version = options["meetup_api_version"] || options[:meetup_api_version]
       @read_method = options["read_method"] || options[:read_method]
       @filter_hash = options["filter_hash"] || options[:filter_hash]
       
     end
     def perform(options = nil)
       hydra = Typhoeus::Hydra.new
       req = Typhoeus::Request.new("http://api.meetup.com/#{@read_method}.json/?#{@filter_hash.to_a.map{|a|a.join("=")}.join("&")}&key=#{@meetup_api_key}")
       req.on_complete do |response|
         ActiveSupport::JSON.decode(response.body)
       end
       hydra.queue(req)
       hydra.run
       resp = req.handled_response
       resp["results"].each do |e|  
          File.open('/tmp/result_set', 'wb') do |f|
            f.write(e)
          end
           #         
           # source = Source.new( :title => e["name"], :official_url => e["event_url"] )
           # basename = "/tmp/"+e["photo_url"].split('/').last
           #  File.open(basename, 'wb') do |f|
           #    f.write(open(e["photo_url"]).read)
           #  end
           # source.primary_image = File.open(basename)
           # event = Event.new(:title => source.title, :source => source )
           # me = MeetupEvent.new(:meetup_event_id => e["id"].to_i, :event => event, :name => e["name"], :description => e["description"], :event_url => e["event_url"], :time => Time.parse(e["time"]))
           # me.to_json
           # 
          #MeetupEvent.find_or_create_by_meetup_event_id(:meetup_event_id => e["id"].to_i, :event => event, :name => e["name"], :description => e["description"], :event_url => e["event_url"], :time => Time.parse(e["time"]))
       end
      return true
     end
   end
end