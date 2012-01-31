bash "install s3cmd" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar xfz s3cmd-1.0.0.tar.gz
    cd s3cmd-1.0.0
    python setup.py install
  EOF
  creates "/usr/bin/s3cmd"
end

service "rsyslog"

remote_directory "/etc" do
  source "etc"
  notifies :restart, "service[rsyslog]"
  files_mode "0600"
end

file "/etc/cron.daily/logrotate" do
  action :delete
end

soloist_config = YAML.load_file("/home/ec2-user/soloist/config.yml")

template "/etc/logrotate.d/heroku" do
  source "/etc/logrotate.d/heroku.erb"
  variables soloist_config
end

template "/root/.s3cfg" do
  source "s3cfg.erb"
  variables soloist_config
end

p soloist_config

execute "test s3cmd" do
  command "s3cmd ls s3://#{soloist_config['bucket_name']}"
end