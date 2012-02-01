require File.dirname(__FILE__) + '/config'

task :default do
  system! %[rsync -az --delete --exclude .git -e ssh . #{CONFIG["host"]}:soloist]
  system! %[ssh -t #{CONFIG["host"]} "cd soloist && sh -ex bootstrap.sh"]
end

def system!(*args)
  puts "-- #{args}"
  system(*args) or raise "system!(#{args}) failed"
end