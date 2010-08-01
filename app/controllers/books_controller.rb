require 'nokogiri'
class BooksController < ApplicationController
  # GET /books
  # GET /books.xml
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])
    @book.source = Source.new( :title => @book.title, :official_url => params[:source_url] )
    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.xml { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  # GET /books/find
  def find
    if request.xhr?
      if params[:add_book]
        result = params[:book_id] ? Nokogiri::XML.parse(open('http://books.google.com/books/feeds/volumes?q='+params[:book_id])) : nil
        book = result.css('entry').first
        render :partial => "add_book", :locals => { :book => book }
      else
        feed_content = params[:query] ? Nokogiri::XML.parse(open('http://books.google.com/books/feeds/volumes?q='+params[:query])) : nil
        books = feed_content.css('entry')
        render :partial => "books", :locals => { :books => books }
      end  
    end
  end
  
  def import_from_google
    @book = Book.import_from_google(params[:book_data])
    redirect_to(@book, :notice => 'Book was successfully created.')
  end
  
end
