remote_file "#{Chef::Config[:file_cache_path]}/s3cmd-1.0.0.tar.gz" do
  source "http://sourceforge.net/projects/s3tools/files/s3cmd/1.0.0/s3cmd-1.0.0.tar.gz/download"
end

bash "install s3cmd" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar xvfz s3cmd-1.0.0.tar.gz
    python setup.py install
  EOF
  creates "/usr/bin/s3cmd"
end