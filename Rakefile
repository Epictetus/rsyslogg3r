require File.dirname(__FILE__) + '/config'

task :default do
  sh %[rsync -az --delete --exclude .git -e ssh . #{CONFIG["host"]}:soloist]
  sh %[ssh -t #{CONFIG["host"]} "cd soloist && sh -ex bootstrap.sh"]
end

task :tail do
  sh %[ssh -t #{CONFIG["host"]} "sudo tail -F /var/log/{messages,secure,cron,logrotate.log}"]
end

task :ssh do
  sh %[ssh #{CONFIG["host"]}]
end

task :create do
  sh %[ec2-run-instances ami-31814f58 -t c1.medium]
end