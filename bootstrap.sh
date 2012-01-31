command -v gem || { sudo yum install -y rubygems; }
command -v soloist || { sudo gem install soloist-0.9.4.gem; }
soloist