require File.dirname(__FILE__) + '/../../../config'

cookbook_file "s3cmd-1.0.0.tar.gz"

bash "install s3cmd" do
  cwd Chef::Config[:cache_dir]
  code <<-EOF
    tar xfz s3cmd-1.0.0.tar.gz
    cd s3cmd-1.0.0
    python setup.py install
  EOF
  creates "/usr/bin/s3cmd"
end

template "/root/.s3cfg" do
  variables CONFIG
end

execute "test s3cmd" do
  command "s3cmd ls s3://#{CONFIG['bucket_name']}"
end

cookbook_file "daemontools-0.76.tar.gz"

bash "install daemontools" do
  cwd Chef::Config[:cache_dir]
  code <<-EOH
    tar zxvf daemontools-0.76.tar.gz
    cd admin/daemontools-0.76
    perl -pi -e 's/extern int errno;/\#include <errno.h>/' src/error.h
    package/install
  EOH
  creates "/usr/sbin/svstat"
end

service "rsyslog"

cookbook_file "/etc/rsyslog.conf" do
  notifies :restart, "service[rsyslog]"
end

cookbook_file "/etc/logrotate.d/heroku" do
  notifies :restart, "service[rsyslog]"
end

service "crond"

cookbook_file "/etc/cron.hourly/logrotate" do
  notifies :restart, "service[crond]"
  mode "0755"
end

file "/etc/cron.daily/logrotate" do
  notifies :restart, "service[crond]"
  action :delete
end

template "/root/postrotate.sh" do
  variables CONFIG
end