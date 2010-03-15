

class TileRow 
  include MongoMapper::EmbeddedDocument
  include Enumerable
  many :tiles
  
  def each(&block)
    tiles.each(&block)
  end
  
  
end