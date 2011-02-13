class MeritsController < ApplicationController

    rescue_from Exceptions::CharacterMeritNotFound, :with => :character_merit_not_found

    before_filter :set_character, :only => [:index, :new, :create]
    before_filter :set_character_and_merits, :except => [:index, :new, :create]

    # GET /characters/1/merits
    # GET /characters/1/merits.xml
    def index
      @character_merits = @character.character_merits.sort

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @character_merits }
        format.json  { render :json => @character_merits }
      end
    end

    # GET /characters/1/merits/1
    # GET /characters/1/merits/1.xml
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @character_merit }
        format.json  { render :json => @character_merit }
      end
    end

    # GET /characters/1/merits/new
    # GET /characters/1/merits/new.xml
    def new
      @character_merit = CharacterMerit.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @character_merit }
        format.json  { render :json => @character_merit }
      end
    end

    # GET /characters/1/merits/1/edit
    def edit
    end

    # POST /characters/1/merits
    # POST /characters/1/merits.xml
    def create
      @character_merit = CharacterMerit.new(params[:character_merit])
      @character_merit.character = @character

      respond_to do |format|
        if @character_merit.save
          flash[:notice] = 'Character Merit was successfully created.'
          format.html { redirect_to(character_merit_url(@character,@character_merit)) }
          format.xml  { render :xml => @character_merit, :status => :created, :location => @character_merit }
          format.json  { render :json => @character_merit, :status => :created, :location => @character_merit }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @character_merit.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_merit.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /characters/1/merits/1
    # PUT /characters/1/merits/1.xml
    def update
      respond_to do |format|
        if @character_merit.update_attributes(params[:character_merit])
          flash[:notice] = 'Character Merit was successfully updated.'
          format.html { redirect_to(character_merit_url(@character,@character_merit)) }
          format.xml  { head :ok }
          format.json  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @character_merit.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_merit.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /characters/1/merits/1
    # DELETE /characters/1/merits/1.xml
    def destroy
      @character_merit.destroy

      respond_to do |format|
        format.html { redirect_to(character_merits_url(@character)) }
        format.xml  { head :ok }
        format.json  { head :ok }
      end
    end

  private

    #--- my controller methods ---#

    # initialize character with no merit
    def set_character
      @character = Character.find(params[:character_id])
      @merit = nil
      @character_merit = nil
    end

   # initialize controller attributes for character and merit
   def set_character_and_merits
     set_character
     @character_merit = CharacterMerit.find(params[:id])
     raise Exceptions::CharacterMeritNotFound if (@character_merit.blank? || (@character_merit.character != @character))
     @merit = @character_merit.merit
     raise Exceptions::CharacterMeritNotFound if @merit.blank?
   end

   # Error message for merit not found
   def character_merit_not_found
     flash[:error] = "#{@character.name} does not have access to merit ##{params[:id]}."
     redirect_to character_url(@character)
   end

end
