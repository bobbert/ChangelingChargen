class ContractsController < ApplicationController

    rescue_from Exceptions::CharacterContractNotFound, :with => :character_contract_not_found
    rescue_from ActiveRecord::RecordNotFound, :with => :character_not_found

    before_filter :set_character, :only => [:index, :new, :create]
    before_filter :set_character_and_contracts, :except => [:index, :new, :create, :dot_range]

    include CharactersHelper

    # GET /characters/1/contracts
    # GET /characters/1/contracts.xml
    # GET /characters/1/contracts.json
    def index
      @character_contracts = @character.character_contracts.sort

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @character_contracts }
        format.json  { render :json => @character_contracts }
      end
    end

    # GET /characters/1/contracts/1
    # GET /characters/1/contracts/1.xml
    # GET /characters/1/contracts/1.json
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @character_contract }
        format.json  { render :json => @character_contract }
      end
    end

    # GET /characters/1/contracts/new
    # GET /characters/1/contracts/new.xml
    # GET /characters/1/contracts/new.json
    def new
      @character_contract = CharacterContract.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @character_contract }
        format.json  { render :json => @character_contract }
      end
    end

    # GET /characters/1/contracts/1/edit
    def edit
    end

    # POST /characters/1/contracts
    # POST /characters/1/contracts.xml
    # POST /characters/1/contracts.json
    def create
      @character_contract = CharacterContract.new(params[:character_contract])
      @character_contract.character = @character

      respond_to do |format|
        if @character_contract.save
          flash[:notice] = 'Character Contract was successfully created.'
          format.html { redirect_to(character_contract_url(@character,@character_contract)) }
          format.xml  { render :xml => @character_contract, :status => :created, :location => @character_contract }
          format.json  { render :json => @character_contract, :status => :created, :location => @character_contract }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @character_contract.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_contract.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /characters/1/contracts/1
    # PUT /characters/1/contracts/1.xml
    # PUT /characters/1/contracts/1.json
    def update
      respond_to do |format|
        if @character_contract.update_attributes(params[:character_contract])
          flash[:notice] = 'Character Contract was successfully updated.'
          format.html { redirect_to(character_contract_url(@character,@character_contract)) }
          format.xml  { head :ok }
          format.json  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @character_contract.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_contract.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /characters/1/contracts/1
    # DELETE /characters/1/contracts/1.xml
    # DELETE /characters/1/contracts/1.json
    def destroy
      respond_to do |format|
        if @character_contract.destroy
          format.html { redirect_to(character_contracts_url(@character)) }
          format.xml  { head :ok }
          format.json  { head :ok }
        else
          format.html { render :action => "show" }
          format.xml  { render :xml => @character_contract.errors, :status => :unprocessable_entity }
          format.json  { render :json => @character_contract.errors, :status => :unprocessable_entity }
        end
      end
    end

    #--- my controller methods ---#

    # GET /characters/1/contracts/1/dot_range.json
    def dot_range
      dot_range_vals = dot_range_list(1, 5)
      respond_to do |format|
        format.json  { render :json => dot_range_vals }
      end
    end

  private

    # initialize character with no contract
    def set_character
      @character = Character.find(params[:character_id])
      @contract = nil
      @character_contract = nil
    end

   # initialize controller attributes for character and contract
   def set_character_and_contracts
     set_character
     @character_contract = CharacterContract.find(params[:id])
     raise Exceptions::CharacterContractNotFound if (@character_contract.blank? || (@character_contract.character != @character))
     @contract = @character_contract.contract
     raise Exceptions::CharacterContractNotFound if @contract.blank?
   end

   # Error message for skill not found
   def character_not_found
     flash[:error] = "Character ##{params[:character_id]} cannot be found."
     respond_to do |format|
       format.html { redirect_to characters_url }
       format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
       format.json  { render :json => @character.errors, :status => :unprocessable_entity }
     end
   end

   # Error message for contract not found
   def character_contract_not_found
     flash[:error] = "#{@character.name} does not have access to contract ##{params[:id]}."
     redirect_to character_url(@character)
   end

end
