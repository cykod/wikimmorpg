
class Location < MongoBase
  include MongoMapper::Document
  include Enumerable
  key :name, String, :required => true
  key :rows, Integer, :required => true
  key :cols, Integer, :required  => true
  
  before_create :create_tiles
  
  many :portals
  
  many :tile_rows
  
  def everyone
    Player.all(:conditions => {:location_id => self.id.to_s})
  end

  def map
    self.tile_rows
  end
  
  def map_data
    self.tile_rows.map do |row|
      row.tiles.map(&:to_hash)
    end
  end
  
  def at(row,col)
    self.map[row].tiles[col]
  end
  
  def each(&block)
    tile_rows.each(&block)
  end
  
  def create_tiles
    self.tile_rows = (0..self.rows-1).collect do |row_idx|
      row = TileRow.new 
      row.tiles = (0..self.cols-1).collect do |col_idx|
        Tile.new(:col => col_idx, :row => row_idx)
      end
      row
    end
  end
  
  def tile_row_data=(val)
    ordered_rows = val.to_a.sort { |a,b| a[0].to_i <=> b[0].to_i }.map { |elm| elm[1] }
    ordered_rows.each_with_index do |row,row_idx|
      col = row.to_a.sort { |a,b| a[0].to_i <=> b[0].to_i }.map { |elm| elm[1] }
      col.each_with_index do |tile_ref,col_idx|
         self.at(row_idx,col_idx).tile_definition_id = tile_ref.blank? ? nil : tile_ref
      end
    end
  end
  
  # Eventually pick a open spot
  def starting_position
    { :x => 1, :y => 1 }
  end

  def generate_move(player,diffy,diffx)
    desty = player.row + diffy
    destx = player.col + diffx
    return no_move(player) if(desty < 0 || desty >= self.rows) 
    return no_move(player) if(destx < 0 || destx >= self.cols)
    tile = self.at(desty,destx)
    return no_move(player) if tile.solid
    player.update_attributes(:col => destx, :row => desty)
    { :x =>  destx, :y => desty}
  end
  
  def no_move(player)
    { :x => player.col, :y => player.row }
  end
end