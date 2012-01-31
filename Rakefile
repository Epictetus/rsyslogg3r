def system!(*args)
  system(*args) or raise "system failed! #{args.inspect}"
end

task :default do
  host = ENV['REMOTE_HOST']
  raise "REMOTE_HOST is not set" unless host
  system! %[rsync -avz --delete --exclude .git -e ssh . #{host}:soloist]
  system! %[ssh -t #{host} "cd soloist && sh -ex bootstrap.sh"]
end