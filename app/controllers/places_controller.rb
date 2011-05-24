class PlacesController < ApplicationController
  # GET /places
  # GET /places.xml
  def index
    @places = Place.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @places }
    end
  end
  
  def search
  	@place = Place.find(params[:name])
  	place = Place.find_by_name(@place.name)
  	
  	if place
  		flash[:notice] = "found."
  	else
  		flash[:notice] = "gubaon"
  	end
  	
  	respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end
  
  
  
  
  
  def login
	  if request.post? and params[:user]
		@user = User.new(params[:user])
	 
		user = User.find_by_username(@user.username)
		
		if user and user.password_matches?(@user.password)
		  session[:user_id] = user.id
		  user.save
	 
		  if user.account.eql?("admin")
		    redirect_to :action => "admin"
		  else
		    redirect_to :action => "user"
		  end
		else
		  flash[:notice] = "Sorry, no user was found with that username/password combination."
		end
	  end
  end
  
  
  
  
  
  
  
  
  
  
  

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to(@place, :notice => 'Place was successfully created.') }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to(@place, :notice => 'Place was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(places_url) }
      format.xml  { head :ok }
    end
  end
end