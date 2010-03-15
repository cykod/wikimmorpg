require 'mongo_mapper'

configfile = "#{RAILS_ROOT}/config/mongodb.yml"
if File.exist? configfile
  config = YAML.load(File.read(configfile))[RAILS_ENV]
  if config
    MongoMapper.connection = Mongo::Connection.new(config["server"], config["port"] || 27017)
    MongoMapper.database = config["database"]
  end
end

