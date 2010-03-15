
class Item
  include MongoMapper::EmbeddedDocument
  
  key :name, String
  
end