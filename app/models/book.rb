class Book < ActiveRecord::Base
  require 'nokogiri'
  has_one :source, :as => :resourceful
  has_many :prices
  validates_presence_of :title, :description
  
  def self.import_from_google(xml,opts={})
    doc = Nokogiri::XML(xml).css('entry')
    
    title = doc.css('title')[0] ? doc.css('title')[0].text : nil
    description = doc.css('description') ? doc.css('description').text : nil
    subtitle = doc.css('title')[1] ? doc.css('title')[1].text : nil
    date = doc.css('date') ? doc.css('date').text : nil
    isbn = doc.css('identifier')[2] ? doc.css('identifier')[2].text.gsub('ISBN:','') : nil
    publisher = doc.css('publisher') ? doc.css('publisher').text : nil
    source_url = doc.css('link')[1].attr('href')
    authors = doc.css('creator')
    authors.each do |author|
      Profile.new :full_name => author.text
    end
    source = Source.new( :title => title, :official_url => source_url )
    File.open(doc.css('identifier').text.split(':').first, 'wb') do |f|
      f.write(open(doc.css('link').first.attr('href').gsub('zoom=5','zoom=0')).read)
    end
    source.primary_image = File.open(doc.css('identifier').text.split(':').first)
    book = Book.create!( :title => title, :subtitle => subtitle, :description => description, :isbn => isbn, :publisher => publisher, :source => source, :print_date =>  Time.local(doc.css('date').first.text,"jan",1,20,15,1))
    book                    
  end
  
end