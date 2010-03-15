
class Player
  include MongoMapper::Document
  key :name, String
  
  key :col, Integer
  key :row, Integer
  key :location_id, String
  key :url,String
  
  key :health, Integer, :default => 10
  key :attack, Integer, :default => 1
  key :defense, Integer, :default => 1
  key :gold, Integer, :default => 0
  key :occupation, String, :default => 'thief'
  
  many :items
  belongs_to :location
  
  
  def self.play(name,url)
    room = random_room
    starting_pos = room.starting_position
    Player.create(:name => name,:location => room, :col => starting_pos[:x], :row => starting_pos[:y])
  end
  
  def self.random_room
    Location.first # this might need some work..
  end
  
  def position
    { :col => self.col, :row => self.row }
  end
  
  def valid_move?(diffy,diffx)
    (diffy.to_i.abs + diffx.to_i.abs) == 1
  end
end