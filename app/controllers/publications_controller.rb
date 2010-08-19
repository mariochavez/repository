class PublicationsController < ApplicationController
  before_filter :authenticate_user!, :my_publications
  
  # GET /publications
  # GET /publications.xml
  def index   
    #The whole if/case statement below can be replaced by the following commented code, change it if you feel it won't hurt performance:
    #
    # if params[:type].present?
    #   @publications = Publication.send(params[:type]).latest rescue nil
    # else
    #   @publications = Publication.latest
    # end
    
    if params[:type].present?
      case params[:type]
        when "messages" then @publications = Publication.latest.messages
        when "uploads"  then @publications = Publication.latest.uploads
        else @publications = nil
      end
    else
      @publications = Publication.latest
    end
    
    # This document should be replaced by one from the application or a partial
    render '../../public/404.html', :layout => false if @publications.nil?
  end
  
  def mypublications
    @publications = current_user.publications.latest
  end

  # GET /publications/1
  # GET /publications/1.xml
  def show
    @publication = Publication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publication }
    end
  end

  # GET /publications/new
  # GET /publications/new.xml
  def new
    @publication = Publication.new
    @publication.attachments.build
  end

  # GET /publications/1/edit
  def edit
    @publication = current_user.publications.find(params[:id])
  end

  # POST /publications
  # POST /publications.xml
  def create
    @publication = current_user.publications.new(params[:publication])

    respond_to do |format|
      if @publication.save
        format.html { redirect_to(@publication, :notice => t(:publication_created)) }
        format.xml  { render :xml => @publication, :status => :created, :location => @publication }
        update_category
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /publications/1
  # PUT /publications/1.xml
  def update
    @publication = current_user.publications.find(params[:id])

    respond_to do |format|
      if @publication.update_attributes(params[:publication])
        format.html { redirect_to(@publication, :notice => 'Publication was successfully updated.') }
        format.xml  { head :ok }
        update_category
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.xml
  def destroy
    @publication = current_user.publications.find(params[:id])
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to(publications_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def my_publications
    @mypublications = current_user.publications.order('created_at desc').limit(5)
  end
  
  def update_category
    if @publication.attachments.count > 0
      @publication.update_attributes(:category => 1) 
    else
      @publication.update_attributes(:category => 0) 
    end
  end
  
end
