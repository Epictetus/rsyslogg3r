task :default do
  raise "REMOTE_HOST is not set" unless host = ENV['REMOTE_HOST']
  raise ".s3cfg doesn't exist" unless File.exist?("#{ENV['HOME']}/.s3cfg")

  system! %[rsync -az --delete --exclude .git -e ssh . #{host}:soloist]
  system! %[rsync -az -e ssh ~/.s3cfg #{host}:]
  system! %[ssh -t #{host} "cd soloist && sh -ex bootstrap.sh"]
end

def system!(*args)
  system(*args) or raise "system failed! #{args.inspect}"
end