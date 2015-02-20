configure do
  opts = YAML.load_file(File.join(settings.root, 'config', 'quick_file.yml'))
  QuickFile.configure(opts[settings.environment.to_s])
end
