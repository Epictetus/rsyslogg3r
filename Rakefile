require File.dirname(__FILE__) + '/config'

task :default do
  sh %[rsync -az --delete --exclude .git -e ssh . #{CONFIG["host"]}:soloist]
  sh %[ssh -t #{CONFIG["host"]} #{Shellwords.shellescape <<-END}]
    cd soloist
    command -v gem || { sudo yum install -y rubygems ruby-devel make gcc; }
    command -v bundle || { sudo gem install bundler-1.0.21.gem --no-ri --no-rdoc; }
    bundle install --local --quiet
    soloist
  END
end

task :tail do
  sh %[ssh -t #{CONFIG["host"]} "sudo tail -F /var/log/{messages,secure,cron,logrotate.log}"]
end

task :ssh do
  sh %[ssh #{CONFIG["host"]}]
end

task :create, :key do |task, args|
  raise "specify the key pair to use with #{task.name}[KEYPAIR]" unless args.key
  sh %[ec2-run-instances ami-31814f58 -t c1.medium -k #{args.key}]
  sh %[ec2-authorize default -P tcp -p 514 -u 098166147350 -o logplex; true]
end