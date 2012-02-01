require File.dirname(__FILE__) + '/config'

task :default do
  required_keys = %w[bucket_name access_key secret_key host]
  raise "#{required_keys.inspect} are required in config.yml" if required_keys.find { |key| CONFIG[key].nil? || CONFIG[key] == '' }
  
  system! %[rsync -az --delete --exclude .git -e ssh . #{CONFIG["host"]}:soloist]
  system! %[ssh -t #{CONFIG["host"]} "cd soloist && sh -ex bootstrap.sh"]
end

def system!(*args)
  puts "-- #{args}"
  system(*args) or raise "system!(#{args}) failed"
end