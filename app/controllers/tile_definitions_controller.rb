class TileDefinitionsController < ApplicationController
  # GET /tile_definitions
  # GET /tile_definitions.xml
  def index
    @tile_definitions = TileDefinition.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tile_definitions }
    end
  end

  # GET /tile_definitions/1
  # GET /tile_definitions/1.xml
  def show
    @tile_definition = TileDefinition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tile_definition }
    end
  end

  # GET /tile_definitions/new
  # GET /tile_definitions/new.xml
  def new
    @tile_definition = TileDefinition.new

    respond_to do |format|
      format.html { render :action => 'edit'}
      format.xml  { render :xml => @tile_definition }
    end
  end

  # GET /tile_definitions/1/edit
  def edit
    @tile_definition = TileDefinition.find(params[:id])
  end

  # POST /tile_definitions
  # POST /tile_definitions.xml
  def create
    @tile_definition = TileDefinition.new(params[:tile_definition])

    respond_to do |format|
      if @tile_definition.save
        flash[:notice] = 'TileDefinition was successfully created.'
        format.html { redirect_to(@tile_definition) }
        format.xml  { render :xml => @tile_definition, :status => :created, :location => @tile_definition }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tile_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tile_definitions/1
  # PUT /tile_definitions/1.xml
  def update
    @tile_definition = TileDefinition.find(params[:id])

    respond_to do |format|
      if @tile_definition.update_attributes(params[:tile_definition])
        flash[:notice] = 'TileDefinition was successfully updated.'
        format.html { redirect_to(@tile_definition) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tile_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tile_definitions/1
  # DELETE /tile_definitions/1.xml
  def destroy
    @tile_definition = TileDefinition.find(params[:id])
    @tile_definition.destroy

    respond_to do |format|
      format.html { redirect_to(tile_definitions_url) }
      format.xml  { head :ok }
    end
  end
end
