module TileDefinitionsHelper
  
  def tile_image_tag(tile,size)
    if tile.tile_definition && tile.tile_definition.image
      image_tag tile.tile_definition.image.url(size) 
    else
      image_tag "/images/spacer.gif", :width => 32,:height =>32
    end
  end
  
  def tile_hidden_fields(tile)
    hidden_field_tag "location[tile_row_data][#{tile.row}][#{tile.col}]", tile.tile_definition_id, :class => 'tile_data'
  end
end
