

class TileDefinition < MongoBase
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :solid, Boolean
  key :image_file_name, String
  key :image_content_type, String
  key :image_file_size, Integer
  timestamps! 
  
  has_attached_file :image,
    :styles => {
      :small => '32x32',
      :tile => '64x64',
      :largetile  => '128x128'
      }
      
   
       def logger
         Rails.logger
       end


       
end