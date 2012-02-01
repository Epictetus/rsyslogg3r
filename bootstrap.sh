command -v gem || { sudo yum install -y rubygems ruby-devel make gcc; }
command -v bundle || { sudo gem install bundler-1.0.21.gem --no-ri --no-rdoc; }
bundle install --local --quiet
soloist