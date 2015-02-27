configure do
  yfp = ENV['QUICK_FILE_CONFIG']
  if yfp.nil?
    yfp = File.join(settings.root, 'config', 'quick_file.yml')
  end
  opts = YAML.load_file(yfp)
  QuickFile.configure(opts[settings.environment.to_s])
end
