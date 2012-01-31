sudo yum -C install -y rubygems ruby-devel make gcc
command -v soloist || { sudo gem install soloist-0.9.4.gem --no-ri --no-rdoc; }
soloist