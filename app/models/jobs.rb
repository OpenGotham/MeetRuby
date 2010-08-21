module Jobs
  
  class TestJob
     attr_accessor :user_id
     def initialize(options)
       @user_id = options["user_id"] || options[:user_id]
     end
     def perform(options = nil)
       user = User.find(@user_id)
       logger ||= Rails && Rails.logger ? Rails.logger : Logger.new(STDOUT)
       logger.info "uid #{user ? user.id : 'no user'}"

       return true
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
         
          source = Source.new( :title => e["name"], :official_url => e["event_url"] )
          basename = "/tmp/"+e["photo_url"].split('/').last
           File.open(basename, 'wb') do |f|
             f.write(open(e["photo_url"]).read)
           end
          source.primary_image = File.open(basename)
          event = Event.new(:title => source.title, :source => source )
         MeetupEvent.find_or_create_by_meetup_event_id(:meetup_event_id => e["id"].to_i, :event => event, :name => e["name"], :description => e["description"], :event_url => e["event_url"], :time => Time.parse(e["time"]))
       end
      return true
     end
   end
end