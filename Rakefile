task :default do
  raise "REMOTE_HOST is not set" unless host = ENV['REMOTE_HOST']
  system! %[rsync -avz --delete --exclude .git -e ssh . #{host}:soloist]
  system! %[ssh -t #{host} "cd soloist && sh -ex bootstrap.sh"]
end

def system!(*args)
  system(*args) or raise "system failed! #{args.inspect}"
end