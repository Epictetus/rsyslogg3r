require File.dirname(__FILE__) + '/../../../config'

bash "install s3cmd" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar xfz s3cmd-1.0.0.tar.gz
    cd s3cmd-1.0.0
    python setup.py install
  EOF
  creates "/usr/bin/s3cmd"
end

template "/root/.s3cfg" do
  source "s3cfg.erb"
  variables CONFIG
end

execute "test s3cmd" do
  command "s3cmd ls s3://#{CONFIG['bucket_name']}"
end

service "rsyslog"

cookbook_file "/etc/rsyslog.conf" do
  notifies :restart, "service[rsyslog]"
  mode "0600"
end

service "crond"

cookbook_file "/etc/cron.hourly/logrotate" do
  notifies :restart, "service[crond]"
  mode "0755"
end

file "/etc/cron.daily/logrotate" do
  action :delete
end

template "/etc/logrotate.d/heroku" do
  source "/etc/logrotate.d/heroku.erb"
  variables CONFIG
end