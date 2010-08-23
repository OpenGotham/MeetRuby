class Feed < ActiveRecord::Base
  has_many :sources, :as  => :resourceful
  
  validates_presence_of :feed_url
  after_create :import_feed_posts
  
      
  protected
    def import_feed_posts
      @feed_content = Nokogiri::XML(open(self.feed_url))
      
      #@feed_content = FeedNormalizer::FeedNormalizer.parse open(self.feed_url)
      #if @feed_content.last_updated > self.last_modified
      items = @feed_content.css('item').blank? ? @feed_content.css('entry') : @feed_content.css('item')
      items.each do |e|
        @source = Source.new( :title => e.css('title').text, :released => e.css('pubDate').blank? ? e.css('published').first.text : e.css('pubDate').text)
        @source.topic_category_list = e.css('category').map{|c|c.text.blank? ? c.attr('term') : c.text }
        @post = Post.create({:source =>  @source, :content => e.css('content').text.blank? ? e.css('description').text : e.css('content').text, :author => e.css('author').text, :summary => e.css('description').blank? ? e.css('summary').text : e.css('description').text })
      end
          
      #end
      
    end
end
