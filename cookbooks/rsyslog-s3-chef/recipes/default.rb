bash "install s3cmd" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar xfz s3cmd-1.0.0.tar.gz
    cd s3cmd-1.0.0
    python setup.py install
  EOF
  creates "/usr/bin/s3cmd"
end

cookbook_file "/etc/rsyslog.conf" do
  source "rsyslog.conf"
  notifies :restart, "service[rsyslog]"
end

service "rsyslog"