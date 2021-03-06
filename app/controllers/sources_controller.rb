class SourcesController < ApplicationController
  # GET /sources
  # GET /sources.xml
  def index
    @sources = Source.all
    #Source.order("created_at DESC").limit(10).order("rand()")
    #@feed_posts = Source.order("rand()").all(:conditions => {:resourceful_type => 'Post'},:limit => 10)
    #@feed_posts = Source.all(:conditions => {:resourceful_type => 'Post'})
    #@feed_posts = Source.where("resourceful_type = 'Post'").order("released DESC")
    # .all.where("resourceful_type = 'Post'").order("released ASC").limit(10)
    @feed_posts = Source.all(:conditions => {:resourceful_type => 'Post'}, :order => "released DESC")
    #@feed_posts = Source.all(:conditions => {:resourceful_type => 'Post'}, :order => "released DESC",:limit => 10)
    @video_feature = Source.where("resourceful_type = 'Video'").limit(1).order("rand()").first
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sources }
    end
  end

  # GET /sources/1
  # GET /sources/1.xml
  def show
    @source = Source.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @source }
    end
  end

  # GET /sources/new
  # GET /sources/new.xml
  def new
    @source = Source.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @source }
    end
  end

  # GET /sources/1/edit
  def edit
    @source = Source.find(params[:id])
  end

  # POST /sources
  # POST /sources.xml
  def create
    @source = Source.new(params[:source])

    respond_to do |format|
      if @source.save
        format.html { redirect_to(@source, :notice => 'Source was successfully created.') }
        format.xml  { render :xml => @source, :status => :created, :location => @source }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sources/1
  # PUT /sources/1.xml
  def update
    @source = Source.find(params[:id])

    respond_to do |format|
      if @source.update_attributes(params[:source])
        format.html { redirect_to(@source, :notice => 'Source was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.xml
  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    respond_to do |format|
      format.html { redirect_to(sources_url) }
      format.xml  { head :ok }
    end
  end
end
