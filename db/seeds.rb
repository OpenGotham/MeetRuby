# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


#tumbler feeds
mjordings_feed = "http://www.iequalsi.com/rss"
hamins_feed = "http://harisamin.tumblr.com/"
#custom rss
bs = "http://brainspl.at/xml/rss20/feed.xml"
#feeds.feedburner 
kz = "http://feeds.feedburner.com/KatzGotYourTongue"


blogs = [
  mjordings_feed, hamins_feed, bs, kz, 
  "http://feeds.feedburner.com/RidingRails", 
  "http://rubyreflector.com/feed.xml"
  "http://feeds2.feedburner.com/engineyard", 
  "http://feeds.pivotallabs.com/pivotallabs/blog.atom"
  "http://yehudakatz.com/rss"
  "http://feeds.feedburner.com/KatzGotYourTongue", 
  "http://feeds.feedburner.com/thechangelog"
  
  ]
  
  
podcasts = [
  {:audio => "", :transcribed => "feed://feeds.feedburner.com/rubyonrails_transcript"}, "http://podcast.rubyonrails.org/"
  
]
"http://www.engineyard.com/videos/demos",
"http://www.engineyard.com/videos/tutorials",
"http://www.engineyard.com/videos/keynotes",
"http://feeds.feedburner.com/thechangelog"

screencasts = ["http://www.engineyard.com/videos", "feed://feeds.feedburner.com/railscasts", "feed://video.google.com/videosearch?q=ruby+screencast&hl=en&client=safari&rls=en&prmd=v&output=rss"]

events = "http://www.engineyard.com/developer/events,"

