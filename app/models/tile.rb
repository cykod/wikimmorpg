

class Tile
  include MongoMapper::EmbeddedDocument
  
  key :row, Integer, :required => true
  key :col, Integer, :required => true
  key :tile_definition_id, String
  key :prop_definition_id, String
  
  belongs_to :tile_definition
  
  belongs_to :prop
  
  def to_hash
    { :row => row, :col => col,
      :url => self.tile_image_url(:tile),
      :solid => self.tile_definition.solid
      }
  end
  
  def solid
    self.tile_definition ? self.tile_definition.solid : false
  end
  
  def tile_image_url(size)
    if self.tile_definition && self.tile_definition.image
      self.tile_definition.image.url(size) 
    else
      "/images/spacer.gif"
    end
  end
  
end