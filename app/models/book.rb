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
    
    book = Book.create!( :title => title, :subtitle => subtitle, 
                         :description => description, :isbn => isbn, :publisher => publisher)
                         # :print_date => FEED ONLY HAS YEAR, NOT A PROPER DATE FIELD 
    book.source = Source.new( :title => title, :official_url => source_url )
    book                    
  end
  
end