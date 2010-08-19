class Feed < ActiveRecord::Base
  has_many :sources, :as  => :resourceful
  
  validates_presence_of :feed_url
  after_create :import_feed_posts
  
      
  protected
    def import_feed_posts
      @feed_content = FeedNormalizer::FeedNormalizer.parse open(self.feed_url)
      #if @feed_content.last_updated > self.last_modified
      @feed_content.entries.each do |e|
        @source = Source.new( :title => e.title, :released => e.last_updated.to_datetime)
        @post = Post.create({:source =>  @source, :content => e.content, :author => e.author.strip, :summary => e.description })
      end
          
      #end
      
    end
end
