module ResponseCache

  def self.get(store, path)
    self.store[[store, path]]
  end

  def self.cache(store, path, resp)
    self.store[[store, path]] = resp
  end

  def self.store
    @store ||= {}
  end

end
