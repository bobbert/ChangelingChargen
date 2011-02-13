class SkillsController < ApplicationController

    rescue_from Exceptions::CharacterSkillNotFound, :with => :character_skill_not_found

    before_filter :set_character, :only => [:index, :new, :create]
    before_filter :set_character_and_skills, :except => [:index, :new, :create]

    # GET /characters/1/skills
    # GET /characters/1/skills.xml
    def index
      @character_skills = @character.character_skills.sort

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @character_skills }
        format.json  { render :json => @character_skills }
      end
    end

    # GET /characters/1/skills/1
    # GET /characters/1/skills/1.xml
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @character_skill }
        format.json  { render :json => @character_skill }
      end
    end

    # GET /characters/1/skills/new
    # GET /characters/1/skills/new.xml
    def new
      @character_skill = CharacterSkill.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @character_skill }
        format.json  { render :json => @character_skill }
      end
    end

    # GET /characters/1/skills/1/edit
    def edit
    end

    # POST /characters/1/skills
    # POST /characters/1/skills.xml
    def create
      @character_skill = CharacterSkill.new(params[:character_skill])
      @character_skill.character = @character

      respond_to do |format|
        if @character_skill.save
          flash[:notice] = 'Character Skill was successfully created.'
          format.html { redirect_to(character_skill_url(@character,@character_skill)) }
          format.xml  { render :xml => @character_skill, :status => :created, :location => @character_skill }
          format.json  { render :json => @character_skill, :status => :created, :location => @character_skill }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @character_skill.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_skill.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /characters/1/skills/1
    # PUT /characters/1/skills/1.xml
    def update
      respond_to do |format|
        if @character_skill.update_attributes(params[:character_skill])
          flash[:notice] = 'Character Skill was successfully updated.'
          format.html { redirect_to(character_skill_url(@character,@character_skill)) }
          format.xml  { head :ok }
          format.json  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @character_skill.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_skill.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /characters/1/skills/1
    # DELETE /characters/1/skills/1.xml
    def destroy
      @character_skill.destroy

      respond_to do |format|
        format.html { redirect_to(character_skills_url(@character)) }
        format.xml  { head :ok }
        format.json  { head :ok }
      end
    end

  private

    #--- my controller methods ---#

    # initialize character with no skill
    def set_character
      @character = Character.find(params[:character_id])
      @skill = nil
      @character_skill = nil
    end

   # initialize controller attributes for character and skill
   def set_character_and_skills
     set_character
     @character_skill = CharacterSkill.find(params[:id])
     raise Exceptions::CharacterSkillNotFound if (@character_skill.blank? || (@character_skill.character != @character))
     @skill = @character_skill.skill
     raise Exceptions::CharacterSkillNotFound if @skill.blank?
   end

   # Error message for skill not found
   def character_skill_not_found
     flash[:error] = "#{@character.name} does not have access to skill ##{params[:id]}."
     redirect_to character_url(@character)
   end

end
