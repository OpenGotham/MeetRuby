class InquiryChoicesController < ApplicationController
  # GET /inquiry_choices
  # GET /inquiry_choices.xml
  def index
    @inquiry_choices = InquiryChoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inquiry_choices }
    end
  end

  # GET /inquiry_choices/1
  # GET /inquiry_choices/1.xml
  def show
    @inquiry_choice = InquiryChoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inquiry_choice }
    end
  end

  # GET /inquiry_choices/new
  # GET /inquiry_choices/new.xml
  def new
    @inquiry_choice = InquiryChoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inquiry_choice }
    end
  end

  # GET /inquiry_choices/1/edit
  def edit
    @inquiry_choice = InquiryChoice.find(params[:id])
  end

  # POST /inquiry_choices
  # POST /inquiry_choices.xml
  def create
    @inquiry_choice = InquiryChoice.new(params[:inquiry_choice])

    respond_to do |format|
      if @inquiry_choice.save
        format.html { redirect_to(@inquiry_choice, :notice => 'Inquiry choice was successfully created.') }
        format.xml  { render :xml => @inquiry_choice, :status => :created, :location => @inquiry_choice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inquiry_choice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inquiry_choices/1
  # PUT /inquiry_choices/1.xml
  def update
    @inquiry_choice = InquiryChoice.find(params[:id])

    respond_to do |format|
      if @inquiry_choice.update_attributes(params[:inquiry_choice])
        format.html { redirect_to(@inquiry_choice, :notice => 'Inquiry choice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inquiry_choice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiry_choices/1
  # DELETE /inquiry_choices/1.xml
  def destroy
    @inquiry_choice = InquiryChoice.find(params[:id])
    @inquiry_choice.destroy

    respond_to do |format|
      format.html { redirect_to(inquiry_choices_url) }
      format.xml  { head :ok }
    end
  end
end
