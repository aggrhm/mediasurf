require 'bundler/setup'
Bundler.require(:default)

## CONFIGURATION
Dir[File.join(settings.root, 'config', '*.rb')].each {|file| require file}

## ROUTES
get "/*/*" do |conn_name, file_key|
  #logger.info "Conn Name: #{conn_name} File Key: #{file_key}"
  cache_control :public, max_age: 2592000
  obj = QuickFile.storage.get(file_key)
  raise Sinatra::NotFound if obj.nil?

  content_type obj.content_type
  etag obj.etag
=begin
  stream do |out|
    obj.read do |chunk|
      out << chunk
    end
  end
=end
  obj.read
end
