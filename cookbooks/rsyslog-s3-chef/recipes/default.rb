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