
class Prop < MongoBase
   include MongoMapper::Document  
  key :name, String, :required => true
  key :prop_type, String, :required => true
  key :solid, Boolean
  
  key :width, Integer
  key :height, Integer
  
  key :image_file_name, String
  key :image_content_type, String
  key :image_file_size, Integer
  timestamps! 
  
  
end