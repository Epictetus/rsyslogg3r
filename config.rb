require 'yaml'

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config.yml")

REQUIRED_KEYS = %w[bucket_name access_key secret_key host]
raise "#{REQUIRED_KEYS.inspect} are required in config.yml" if REQUIRED_KEYS.find { |key| CONFIG[key].nil? || CONFIG[key] == '' }
