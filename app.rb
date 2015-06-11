require 'bundler/setup'
Bundler.require(:default)

## CONFIGURATION
Dir[File.join(settings.root, 'lib', '*.rb')].each {|file| require file}
Dir[File.join(settings.root, 'config', '*.rb')].each {|file| require file}

## ROUTES
get "/*/*" do |storage_name, file_key|
  #logger.info "Storage Name: #{storage_name} File Key: #{file_key}"
  cache_control :public, max_age: 2592000

  # check cache
  resp = ResponseCache.get(storage_name, file_key)

  if resp.nil?
    obj = QuickFile.storage_for(storage_name).get(file_key)
    raise Sinatra::NotFound if obj.nil?

    resp = {
      content_type: obj.content_type,
      etag: obj.etag,
      data: obj.read
    }
    ResponseCache.cache(storage_name, file_key, resp) if settings.development? && resp[:data]
  end

  content_type resp[:content_type]
  etag resp[:etag]
=begin
  stream do |out|
    obj.read do |chunk|
      out << chunk
    end
  end
=end
  resp[:data]
end
