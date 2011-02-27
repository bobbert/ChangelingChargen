class CharactersController < ApplicationController

  # GET /characters
  # GET /characters.xml
  # GET /characters.json
  def index
    @characters = Character.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @characters }
      format.json  { render :json => @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.xml
  # GET /characters/1.json
  def show
    @character = Character.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @character }
      format.json  { render :json => @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.xml
  # GET /characters/new.json
  def new
    @character = Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character }
      format.json  { render :json => @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = Character.find(params[:id])
  end

  # POST /characters
  # POST /characters.xml
  # POST /characters.json
  def create
    # create character and save, then add Score connector
    @character = Character.new(params[:character])
    respond_to do |format|
      # creating new character, and new association between selected player and character
      if @character.save
        flash[:notice] = 'Character was successfully created.'
        format.html { redirect_to(@character) }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
        format.json  { render :json => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
        format.json  { render :json => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  # PUT /characters/1.json
  def update
    @character = Character.find(params[:id])
    respond_to do |format|
      if @character.update_attributes(params[:character])
        flash[:notice] = 'Character was successfully updated.'
        format.html { redirect_to(@character) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
        format.json  { render :json => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.xml
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to(characters_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end

